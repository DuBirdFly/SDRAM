module sdr_wrapper(
    IfSdr ifSdr
);

    sdr u_sdr(
        .Clk   ( ifSdr.clk   ),
        .Cke   ( ifSdr.cke   ),
        .Cs_n  ( ifSdr.cs_n  ),
        .Ras_n ( ifSdr.ras_n ),
        .Cas_n ( ifSdr.cas_n ),
        .We_n  ( ifSdr.we_n  ),
        .Addr  ( ifSdr.addr  ),
        .Ba    ( ifSdr.ba    ),
        .Dq    ( ifSdr.dq    ),
        .Dqm   ( ifSdr.dqm   )
    );

endmodule