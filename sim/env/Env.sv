class Env extends uvm_env;

    /* Factory Register this Class */
    `uvm_component_utils(Env)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    SdrMstrEnv sdrMstrEnv = SdrMstrEnv::type_id::create("sdrMstrEnv", this);

    function new(string name = "Env", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass
