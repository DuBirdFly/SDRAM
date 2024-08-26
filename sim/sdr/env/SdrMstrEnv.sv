class SdrMstrEnv extends uvm_env;

    /* Factory Register this Class */
    `uvm_component_utils(SdrMstrEnv)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    SdrMstrAgt sdrMstrAgt = SdrMstrAgt::type_id::create("sdrMstrAgt", this);

    function new(string name = "SdrMstrEnv", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

endclass
