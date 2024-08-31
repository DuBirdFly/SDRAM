typedef enum { S_IDLE, S_ACT, S_WR, S_RD, S_PRE, S_LMR, S_REF } t_SDR_STATE;

interface IfUser(input clk);

    t_SDR_STATE SDR_STATE;

    clocking drv_cb @(posedge clk);
        default input #1 output #1;

        output SDR_STATE;
    endclocking

endinterface