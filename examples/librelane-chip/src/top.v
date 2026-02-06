module top (
    `ifdef USE_POWER_PINS
    inout wire IOVDD,
    inout wire IOVSS,
    inout wire VDD,
    inout wire VSS,
    `endif
    inout  logic       io_clock_PAD,
    inout  logic       io_reset_PAD,
    output logic [15:0] uo_PAD
);

    wire [15:0] uo_CORE2PAD;
    wire      io_clock_p2c;
    wire      io_reset_p2c;

    // Power/Ground IO pad instances
    (* keep *) sg13g2_IOPadVdd sg13g2_IOPadVdd_south ();
    (* keep *) sg13g2_IOPadVss sg13g2_IOPadVss_south ();
    // Power/Ground IO pad IO instances
    (* keep *) sg13g2_IOPadIOVdd sg13g2_IOPadIOVdd_south ();
    (* keep *) sg13g2_IOPadIOVss sg13g2_IOPadIOVss_south ();

    sg13g2_IOPadIn sg13g2_IOPad_io_clock (
        `ifdef USE_POWER_PINS
        .vss    (VSS),
        .vdd    (VDD),
        .iovss  (IOVSS),
        .iovdd  (IOVDD),
        `endif
        .p2c (io_clock_p2c), //o
        .pad (io_clock_PAD)  //~
    );

    sg13g2_IOPadIn sg13g2_IOPad_io_reset (
        `ifdef USE_POWER_PINS
        .vss    (VSS),
        .vdd    (VDD),
        .iovss  (IOVSS),
        .iovdd  (IOVDD),
        `endif
        .p2c (io_reset_p2c), //o
        .pad (io_reset_PAD)  //~
    );

    generate
    for (genvar i=0; i<16; i++) begin : sg13g2_IOPadOut30mA_uo
        sg13g2_IOPadOut30mA uo (
            `ifdef USE_POWER_PINS
            .vss    (VSS),
            .vdd    (VDD),
            .iovss  (IOVSS),
            .iovdd  (IOVDD),
            `endif
            .c2p (uo_CORE2PAD[i]),
            .pad (uo_PAD[i])
        );
    end
    endgenerate

    counter_8bit u_counter_8bit_0 (
        .clk_i   (io_clock_p2c),
        .rst_ni  (io_reset_p2c),
        .count_o (uo_CORE2PAD[7:0])
    );

    counter_8bit u_counter_8bit_1 (
        .clk_i   (io_clock_p2c),
        .rst_ni  (io_reset_p2c),
        .count_o (uo_CORE2PAD[15:8])
    );

endmodule