module sdr_wrapper(
    IfSDR ifSDR
);

    sdr u_sdr(
        .Clk   ( ifSDR.clk   ),
        .Cke   ( ifSDR.cke   ),
        .Cs_n  ( ifSDR.cs_n  ),
        .Ras_n ( ifSDR.ras_n ),
        .Cas_n ( ifSDR.cas_n ),
        .We_n  ( ifSDR.we_n  ),
        .Addr  ( ifSDR.addr  ),
        .Ba    ( ifSDR.ba    ),
        .Dq    ( ifSDR.dq    ),
        .Dqm   ( ifSDR.dqm   ),
    );

endmodule