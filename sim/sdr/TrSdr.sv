class TrSdr extends uvm_sequence_item;

    /* Factory Register this Class */
    `uvm_object_utils(TrSdr)

    /* Declare Normal Variables */
    string SdrCmd;

    /* Factory/Object Registration */
    /* Declare Object Handles */
    /* Constrains */

    function new(string name = "TrSdr");
        super.new(name);
    endfunction

endclass