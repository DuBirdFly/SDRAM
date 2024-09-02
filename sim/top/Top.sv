import uvm_pkg::*;
`include "uvm_macros.svh"

// 时钟有可能是 7.5ns (133 MHz), 也就是 3.75ns 翻转一次
`timescale 1ns/1ps

`include "sdr_include.svh"
`include "sdr_wrapper.sv"

`include "Env.sv"
`include "Test.sv"

module Top;

    localparam CLK_PERIOD = 7.5; // 133 MHz
    bit clk;
    always #(CLK_PERIOD/2) clk = ~clk;

    IfSdr ifSdr(clk);

    sdr_wrapper sdr_wrapper(ifSdr);

    initial begin: uvm_config_db_interface
        uvm_config_db#(virtual IfSdr)::set(null, "uvm_test_top", "vifSdr", ifSdr);
        uvm_config_db#(virtual IfSdr)::set(null, "uvm_test_top.env.sdrMstrEnv.sdrMstrAgt.sdrMstrChn", "vifSdr", ifSdr);
    end

    initial begin
        $timeformat(-9, 1, "ns", 9);   // 时间精度, 小数点精度, 字符串后缀, 字符串长度
        run_test("Test");
    end

endmodule
