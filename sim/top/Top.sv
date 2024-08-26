import uvm_pkg::*;
`include "uvm_macros.svh"

// 时钟有可能是 7.5ns (133 MHz), 也就是 3.75ns 翻转一次, 所以 1ps 的时间精度是需要的
`timescale 1ps/1ps

`include "sdr_define.sv"
`include "ifSdr.sv"
`include "sdr_wrapper.sv"

`include "Test.sv"

module Top;

    localparam CLK_PERIOD = 7500; // 133 MHz
    bit clk;
    always #(CLK_PERIOD/2) clk = ~clk;

    IfSdr ifSdr(clk);

    sdr_wrapper sdr_wrapper(ifSdr);

    initial begin: uvm_config_db_interface
        uvm_config_db#(virtual IfSdr)::set(null, "uvm_test_top", "vifSdr", ifSdr);
    end

    initial begin
        $timeformat(-9, 3, "ns", 12);   // 时间精度, 小数点精度, 字符串后缀, 字符串长度
        run_test("Test");
    end

endmodule
