module top(
    `ifdef USE_POWER_PINS
    inout wire IOVDD,
    inout wire IOVSS,
    inout wire VDD,
    inout wire VSS,
    `endif

    inout clk_PAD,
    inout rst_n_PAD,
    inout button_PAD,
    inout [3:0] X_PADs,

    output [6:0] seg0_PADs,
    output [6:0] seg1_PADs
);

endmodule