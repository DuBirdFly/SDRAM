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
        TrSdr tr = TrSdr::type_id::create("tr");
        tr.write = 1;
        if (!tr.randomize() with {addr == {2'h3, 13'h1fff, 9'h000}; len == 7;})
            `uvm_fatal(get_type_name(), "Randomize failed")
        tr.calcu_addr();
        start_item(tr);
        finish_item(tr);
    endtask

endclass
