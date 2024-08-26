class SdrMstrSeq extends uvm_sequence #(TrSdr);

    /* Factory Register this Class */
    `uvm_object_utils(SdrMstrSeq)

    /* Declare Normal Variables */
    /* Declare Object Handles */

    function new(string name = "SdrMstrSeq");
        super.new(name);
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);
        case_run_0();
        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

    virtual task case_run_0();
        TrSdr trSdr;
        `uvm_info(get_type_name(), "case_run_0", UVM_MEDIUM)
        trSdr = TrSdr::type_id::create("trSdr");
        trSdr.SdrCmd = "Init";
        start_item(trSdr);
        finish_item(trSdr);
    endtask

endclass
