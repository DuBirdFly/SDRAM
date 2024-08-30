class SdrMstrChn extends uvm_driver #(TrSdr);

    `include "sdr_parameters.vh"

    /* Factory Register this Class */
    `uvm_component_utils(SdrMstrChn)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfSdr vifSdr;

    function new(string name = "SdrMstrChn", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfSdr)::get(this, "", "vifSdr", vifSdr))
            `uvm_fatal("NOVIF", {"\n    --> Virtual interface must be set for: ", get_full_name()})
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drive(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive(TrSdr tr);
        `uvm_info(get_type_name(), $sformatf("Get A Transaction Command: %s", tr.SdrCmd), UVM_MEDIUM)
        case (tr.SdrCmd)
            "INIT"      : seq_init();
            default     : `uvm_error(get_type_name(), $sformatf("[task drive] Unknown Type: %s", tr.SdrCmd))
        endcase
    endtask

    // SDR Initialization Sequence, SDR-STATE will go to "IDLE"
    virtual task seq_init();
        #50ns @vifSdr.drv_cb;
        vifSdr.drv_cb.cke <= 1'b0;

        #50ns @vifSdr.drv_cb;
        vifSdr.drv_cb.cke <= 1'b1;

        #50ns @vifSdr.drv_cb;
        this.CMD_NOP();

        #100ns @vifSdr.drv_cb;  // actually, need to delay at least 100μs

        this.CMD_PRECHARGE("all");
        repeat (tRP / tCK + 1) this.CMD_NOP();  // tRP (ns), Precharge command period

        this.CMD_REFRESH("auto");
        repeat (tRFC / tCK + 1) this.CMD_NOP(); // tRFC (ns), Refresh to Refresh Command interval time

        this.CMD_REFRESH("auto");
        repeat (tRFC / tCK + 1) this.CMD_NOP(); // tRFC (ns), Refresh to Refresh Command interval time

        this.CMD_LMR('b011_0_010);  // CAS Latency = 3, BT = 0, BL = 4
        repeat (tMRD) this.CMD_NOP();   // tMRD (tCK), Load Mode Register command cycle time
    endtask

    function void set_cmd(bit [3:0] cmd);
        vifSdr.drv_cb.cs_n  <= cmd[3];
        vifSdr.drv_cb.ras_n <= cmd[2];
        vifSdr.drv_cb.cas_n <= cmd[1];
        vifSdr.drv_cb.we_n  <= cmd[0];
    endfunction

    virtual task CMD_NOP();
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0111);
        vifSdr.drv_cb.addr  <= 'x;
        vifSdr.drv_cb.ba    <= 'x;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_LMR(bit [`VIP_SDR_ADDR_WIDTH - 1:0] op_code);
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0000);
        vifSdr.drv_cb.addr  <= op_code;
        vifSdr.drv_cb.ba    <= '0;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_ACTIVE();
    endtask

    virtual task CMD_PRECHARGE(string sub_type = "all", bit [`VIP_SDR_BA_WIDTH - 1:0] bank = 0);
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0010);
        case (sub_type)
            "all"       : vifSdr.drv_cb.addr <= (1'b1 << 10);    // A10 = 1
            "selected"  : vifSdr.drv_cb.addr <= '0;              // A10 = 0
            default     : `uvm_error(get_type_name(), $sformatf("[task CMD_PRECHARGE] Unknown Type: %s", sub_type))
        endcase
        vifSdr.drv_cb.ba    <= bank;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_REFRESH(string sub_type = "auto");
        case (sub_type)
            "auto"      : vifSdr.drv_cb.cke <= 1'b1;
            "self"      : vifSdr.drv_cb.cke <= 1'b0;
            default     : `uvm_error(get_type_name(), $sformatf("[task CMD_REFRESH] Unknown Type: %s", sub_type))
        endcase
        this.set_cmd(4'b0001);
        vifSdr.drv_cb.dqm <= '0;
        vifSdr.drv_cb.dq  <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

endclass