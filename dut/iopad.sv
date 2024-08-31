module iopad(
    input I, EN,
    output C,
    inout IO
);

    assign C = IO;
    assign IO = EN ? I : 1'bz;

endmodule