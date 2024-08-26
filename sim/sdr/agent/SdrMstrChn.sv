class SdrMstrChn extends uvm_driver #(TrSdr);

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

    virtual task reset_signal();
        repeat(5) @(posedge vifSdr.drv_cb);
        vifSdr.drv_cb.cke   <= 1'b0;
        vifSdr.drv_cb.cs_n  <= 1'b1;
        vifSdr.drv_cb.ras_n <= 1'b1;
        vifSdr.drv_cb.cas_n <= 1'b1;
        vifSdr.drv_cb.we_n  <= 1'b1;
        vifSdr.drv_cb.addr  <= '0;
        vifSdr.drv_cb.ba    <= '0;
        repeat(5) @(posedge vifSdr.drv_cb);
        vifSdr.drv_cb.cke    <= 1'b1;
    endtask

    virtual task run_phase(uvm_phase phase);
        reset_signal();
        forever begin
            seq_item_port.get_next_item(req);
            drive(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive(TrSdr tr);
        `uvm_info(get_type_name(), "Get A Transaction", UVM_MEDIUM)
        @(posedge vifSdr.drv_cb);
    endtask

endclass