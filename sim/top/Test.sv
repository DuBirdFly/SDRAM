class Test extends uvm_test;

    /* Factory Register this Class */
    `uvm_component_utils(Test)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfSdr vifSdr;
    Env env = Env::type_id::create("env", this);
    SdrMstrSeq sdrMstrSeq = SdrMstrSeq::type_id::create("sdrMstrSeq");

    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //!set_timeout 不支持单位, 只支持 32 bit (4_294_967_295), 其单位为 timescale 的精度 (1ns/ps 则为 ps)
        uvm_top.set_timeout(500_000_000, 1); // 500_000_000 ps = 500 us

        /* Override */

        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfSdr)::get(this, "", "vifSdr", vifSdr))
            `uvm_fatal("NOVIF", "No IfSdr Interface Specified")
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */

        // set_report_verbosity_level_hier
        // env.axiMstrEnv.axiSlvRef.set_report_verbosity_level_hier(UVM_DEBUG);
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "start_of_simulation_phase: print_topology", UVM_MEDIUM)
        uvm_top.print_topology();
        `uvm_info(get_type_name(), "report_phase: print_factory", UVM_MEDIUM)
        factory.print();
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        sdrMstrSeq.start(env.sdrMstrEnv.sdrMstrAgt.sdrMstrSqr);

        #1us;

        phase.drop_objection(this);
    endtask

endclass