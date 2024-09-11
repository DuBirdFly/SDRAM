class TrSdr extends uvm_sequence_item;
    /* Declare Normal Variables */
    rand bit [`VIP_SDR_DQ_WIDTH - 1:0]      data [$];
    rand bit [`VIP_NATIVE_ADDR_WIDTH - 1:0] addr;
    rand bit [`VIP_SDR_COL_WIDTH - 1:0]     len;
    bit write;

    bit [`VIP_SDR_COL_BASE_ADDR + `VIP_SDR_COL_WIDTH - 1: `VIP_SDR_COL_BASE_ADDR] col; // [8:0], max = 512 = 0x1ff
    bit [`VIP_SDR_ROW_BASE_ADDR + `VIP_SDR_ROW_WIDTH - 1: `VIP_SDR_ROW_BASE_ADDR] row; // [21:9], max = 8192 = 0x1fff
    bit [`VIP_SDR_BA_BASE_ADDR  + `VIP_SDR_BA_WIDTH  - 1: `VIP_SDR_BA_BASE_ADDR]  bank; // [23:22], max = 4 = 0x3

    /* Declare Object Handles */


    /* Factory Register this Class */
    `uvm_object_utils_begin(TrSdr)
        `uvm_field_queue_int(data, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(len, UVM_ALL_ON)
        `uvm_field_int(write, UVM_ALL_ON)
    `uvm_object_utils_end

    /* Constrains */
    constraint c_data {
        data.size() == len + 1;
    }

    function new(string name = "TrSdr");
        super.new(name);
    endfunction

    function void calcu_addr();
        this.col  = addr[`VIP_SDR_COL_BASE_ADDR + `VIP_SDR_COL_WIDTH - 1: `VIP_SDR_COL_BASE_ADDR];
        this.row  = addr[`VIP_SDR_ROW_BASE_ADDR + `VIP_SDR_ROW_WIDTH - 1: `VIP_SDR_ROW_BASE_ADDR];
        this.bank = addr[`VIP_SDR_BA_BASE_ADDR  + `VIP_SDR_BA_WIDTH  - 1: `VIP_SDR_BA_BASE_ADDR];
    endfunction

    function string get_info();
        string info;

        if (write) info = {info, "Sdr Write\n"};
        else       info = {info, "Sdr Read\n"};

        info = {info, $sformatf("addr = 0x%0h (%0d), len = %0d (+1 = %0d)\n", addr, addr, len, len + 1)};
        // info = {info, $sformatf("col = %0d (0x%0h), row = %0d (0x%0h), bank = %0d (0x%0h)\n", col, col, row, row, bank, bank)};
        info = {info, $sformatf("bank = %0d (0x%0h), row = %0d (0x%0h), col = %0d (0x%0h)\n", bank, bank, row, row, col, col)};

        for (int i = 0; i < data.size(); i++) begin
            info = {info, $sformatf("dq[%0d] = 0x%h, ", i, data[i])};
            if (i % 4 == 3) info = {info, "\n"};
        end

        return info;
    endfunction

endclass