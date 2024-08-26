interface IfSdr(
    input logic clk
);

    `include "sdr_parameters.vh"

    logic                               cke;
    logic                               cs_n;
    logic                               ras_n;
    logic                               cas_n;
    logic                               we_n;
    logic [`VIP_SDR_ADDR_WIDTH - 1:0]   addr;
    logic [`VIP_SDR_BA_WIDTH   - 1:0]   ba;
    wire  [`VIP_SDR_DQ_WIDTH   - 1:0]   dq;
    logic [`VIP_SDR_DM_WIDTH   - 1:0]   dqm;

    clocking drv_cb @(posedge clk);
        output cke;
        output cs_n;
        output ras_n;
        output cas_n;
        output we_n;
        output addr;
        output ba;
        inout  dq;
        output dqm;
    endclocking
 
    modport SLAVE (
        input cke, cs_n, ras_n, cas_n, we_n, addr, ba, dqm,
        inout dq
    );

    modport MASTER (
        output cke, cs_n, ras_n, cas_n, we_n, addr, ba, dqm,
        inout dq
    );

endinterface