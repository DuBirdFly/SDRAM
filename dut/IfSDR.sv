interface IfSDR(
    input logic clk
);

    `include "sdr_parameters.vh"

    logic                   cke;
    logic                   cs_n;
    logic                   ras_n;
    logic                   cas_n;
    logic                   we_n;
    logic [ADDR_BITS - 1:0] addr;
    logic [BA_BITS   - 1:0] ba;
    logic [DQ_BITS   - 1:0] dq;
    logic [DM_BITS   - 1:0] dqm;

    clocking DRV_CB @(posedge clk);
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
        input cke, cs_n, ras_n, cas_n, we_n, addr, ba, dqm
        inout dq
    );

    modport MASTER (
        output cke, cs_n, ras_n, cas_n, we_n, addr, ba, dqm
        inout dq
    );

endinterface