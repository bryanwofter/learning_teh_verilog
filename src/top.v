// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,     // 16MHz clock - Built-in, currently unused
    input PIN_14,  // 40MHz clock
    output PIN_13, // Blanking signal
    output PIN_12, // H-sync signal
    output PIN_11, // TODO: Enable/clock for draw core?
    output PIN_10, // V-sync signal
    output PIN_9,  // Address bit 17
    output PIN_8,
    output PIN_7,
    output PIN_6,
    output PIN_5,
    output PIN_4,
    output PIN_3,
    output PIN_2,
    output PIN_1,
    output PIN_24,
    output PIN_23,
    output PIN_22,
    output PIN_21,
    output PIN_20,
    output PIN_19,
    output PIN_18,
    output PIN_17,
    output PIN_16,
    output PIN_15, // Address bit 0
    output USBPU   // USB pull-up resistor
);
    assign USBPU = 0;

    wire w_h_clk,
         w_h_blank,
         w_v_blank;

    clk_divider half_clk(
        .clk(PIN_14),
        .q(w_h_clk)
    );

    display_driver_core#(
        .SIZE(10),
        .V_SHIFT(1),
        .H_BLANK_S(10'b 0110010000),
        .H_SYNC_S(10'b 0110100100),
        .H_SYNC_E(10'b 0111100100),
        .H_BLANK_E(10'b 1000010000),
        .V_BLANK_S(10'b 1001011000),
        .V_SYNC_S(10'b 1001011001),
        .V_SYNC_E(10'b 1001011101),
        .V_BLANK_E(10'b 1001110100)
    ) display_driver(
        .clk(w_h_clk),
        .blanking(PIN_13),
        .h_sync(PIN_12),
        .v_sync(PIN_10),
        .addr({PIN_9,
               PIN_8,
               PIN_7,
               PIN_6,
               PIN_5,
               PIN_4,
               PIN_3,
               PIN_2,
               PIN_1,
               PIN_24,
               PIN_23,
               PIN_22,
               PIN_21,
               PIN_20,
               PIN_19,
               PIN_18,
               PIN_17,
               PIN_16,
               PIN_15})
    );
endmodule
