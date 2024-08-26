class SdrMstrAgt extends uvm_agent;

    /* Factory Register this Class */
    `uvm_component_utils(SdrMstrAgt)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    SdrMstrSqr sdrMstrSqr = SdrMstrSqr::type_id::create("sdrMstrSqr", this);
    SdrMstrChn sdrMstrChn = SdrMstrChn::type_id::create("sdrMstrChn", this);

    function new(string name = "SdrMstrAgt", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sdrMstrChn.seq_item_port.connect(sdrMstrSqr.seq_item_export);
    endfunction

endclass