class SdrMstrChn extends uvm_driver #(TrSdr);

    `include "sdr_parameters.vh"

    /* Factory Register this Class */
    `uvm_component_utils(SdrMstrChn)

    /* Declare Normal Variables */
    typedef enum { NOP, ACT, WR, RD, WRA, RDA, PRE, LMR, REF, TERMINATE } t_SDR_STATE_MACHINE;
    struct {
        t_SDR_STATE_MACHINE CMD = NOP;
        bit [`VIP_SDR_CL_WIDTH - 1:0] CL = 3;
        bit [`VIP_SDR_BT_WIDTH - 1:0] BT = 0;
        bit [`VIP_SDR_BL_WIDTH - 1:0] BL = 8;
        bit BANK0_ACT = 0;
        bit BANK1_ACT = 0;
        bit BANK2_ACT = 0;
        bit BANK3_ACT = 0;
        bit [`VIP_SDR_ROW_WIDTH - 1:0] BANK0_ROW = 0;
        bit [`VIP_SDR_ROW_WIDTH - 1:0] BANK1_ROW = 0;
        bit [`VIP_SDR_ROW_WIDTH - 1:0] BANK2_ROW = 0;
        bit [`VIP_SDR_ROW_WIDTH - 1:0] BANK3_ROW = 0;
    } SDR_STATE;

    /* Declare Object Handles */
    virtual IfSdr vifSdr;

    function new(string name = "SdrMstrChn", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        /* uvm_config_db#(<sub_type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfSdr)::get(this, "", "vifSdr", vifSdr))
            `uvm_fatal("NOVIF", {"\n    --> Virtual-interface must be set for: ", get_full_name()})
        /* uvm_config_db#(<sub_type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
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
            // "TEST_0"    : test_0();
            default     : `uvm_error(get_type_name(), $sformatf("[task drive] Unknown Type: %s", tr.SdrCmd))
        endcase
    endtask

    // SDR Initialization Sequence, SDR-CMD will go to "IDLE"
    virtual task seq_init();
        #50ns @vifSdr.drv_cb;
        vifSdr.drv_cb.cke <= 1'b0;

        #50ns @vifSdr.drv_cb;
        vifSdr.drv_cb.cke <= 1'b1;

        #50ns @vifSdr.drv_cb;
        this.CMD_NOP();

        #100ns @vifSdr.drv_cb;  // actually, need to delay at least 100μs

        this.CMD_PRECHARGE("all");
        repeat ($ceil(tRP / tCK)) this.CMD_NOP();  // tRP (ns), Precharge command period

        this.CMD_REFRESH("auto");
        repeat ($ceil(tRFC / tCK)) this.CMD_NOP(); // tRFC (ns), Refresh to Refresh Command interval time

        this.CMD_REFRESH("auto");
        repeat ($ceil(tRFC / tCK)) this.CMD_NOP(); // tRFC (ns), Refresh to Refresh Command interval time

        this.CMD_LMR({SDR_STATE.CL, SDR_STATE.BT, SDR_STATE.BL});
        repeat (tMRD) this.CMD_NOP();   // tMRD (tCK), Load Mode Register command cycle time

        repeat (10) this.CMD_NOP();     // extra NOPs
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
        SDR_STATE.CMD = LMR;
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0000);
        vifSdr.drv_cb.addr  <= op_code;
        vifSdr.drv_cb.ba    <= '0;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_ACTIVE(bit [`VIP_SDR_BA_WIDTH - 1:0] bank, bit [`VIP_SDR_ROW_WIDTH - 1:0] row);
        SDR_STATE.CMD = ACT;
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0011);
        vifSdr.drv_cb.addr  <= row;
        vifSdr.drv_cb.ba    <= bank;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_READ(
        bit [`VIP_SDR_BA_WIDTH - 1:0] bank,
        bit [`VIP_SDR_COL_WIDTH - 1:0] col,
        bit [`VIP_SDR_DM_WIDTH - 1:0] dqm [$],
        bit auto_precharge = 0
    );
        if (auto_precharge) SDR_STATE.CMD = RDA;
        else                SDR_STATE.CMD = RD;

        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0101);
        vifSdr.drv_cb.addr  <= col;
        vifSdr.drv_cb.ba    <= bank;
        foreach (dqm[i]) begin
            vifSdr.drv_cb.dqm[i] <= dqm[i];
            vifSdr.drv_cb.dq    <= 'z;
            @(posedge vifSdr.drv_cb);
        end
    endtask

    virtual task CMD_WRITE(
        bit [`VIP_SDR_BA_WIDTH - 1:0] bank,
        bit [`VIP_SDR_COL_WIDTH - 1:0] col,
        bit [`VIP_SDR_DM_WIDTH - 1:0] dqm [$],
        bit [`VIP_SDR_DQ_WIDTH - 1:0] dq [$],
        bit auto_precharge = 0
    );
        if (auto_precharge) SDR_STATE.CMD = WRA;
        else                SDR_STATE.CMD = WR;

        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0110);
        vifSdr.drv_cb.addr  <= col;
        vifSdr.drv_cb.ba    <= bank;
        foreach (dqm[i]) begin
            vifSdr.drv_cb.dqm[i] <= dqm[i];
            vifSdr.drv_cb.dq[i] <= dq[i];
            @(posedge vifSdr.drv_cb);
        end
    endtask

    virtual task CMD_PRECHARGE(string sub_type = "all", bit [`VIP_SDR_BA_WIDTH - 1:0] bank = 0);
        SDR_STATE.CMD = PRE;
        vifSdr.drv_cb.cke   <= 1'b1;
        this.set_cmd(4'b0010);
        case (sub_type)
            "all"   : vifSdr.drv_cb.addr <= (1'b1 << 10);    // A10 = 1
            "sel"   : vifSdr.drv_cb.addr <= '0;              // A10 = 0
            default : `uvm_error(get_type_name(), $sformatf("[task CMD_PRECHARGE] Unknown Type: %s", sub_type))
        endcase
        vifSdr.drv_cb.ba    <= bank;
        vifSdr.drv_cb.dqm   <= '0;
        vifSdr.drv_cb.dq    <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_TERMINATE();
        SDR_STATE.CMD = TERMINATE;
        vifSdr.drv_cb.cke <= 1'b1;
        this.set_cmd(4'b0110);
        vifSdr.drv_cb.addr <= 'x;
        vifSdr.drv_cb.ba <= 'x;
        vifSdr.drv_cb.dqm <= '0;
        vifSdr.drv_cb.dq <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

    virtual task CMD_REFRESH(string sub_type = "auto");
        SDR_STATE.CMD = REF;
        case (sub_type)
            "auto"      : vifSdr.drv_cb.cke <= 1'b1;
            "self"      : vifSdr.drv_cb.cke <= 1'b0;     // 休眠状态下的刷新 (Low Power Self Refresh)vh
            default     : `uvm_error(get_type_name(), $sformatf("[task CMD_REFRESH] Unknown Type: %s", sub_type))
        endcase
        this.set_cmd(4'b0001);
        vifSdr.drv_cb.addr <= 'x;
        vifSdr.drv_cb.ba <= 'x;
        vifSdr.drv_cb.dqm <= '0;
        vifSdr.drv_cb.dq  <= 'z;
        @(posedge vifSdr.drv_cb);
    endtask

endclass