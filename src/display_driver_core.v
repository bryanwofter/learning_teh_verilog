module display_driver_core#(
    parameter SIZE                  = 1'b 1,
    parameter V_SHIFT               = 1'b 0,
    localparam D_SIZE               = SIZE * 2,
    localparam V_SIZE               = SIZE - V_SHIFT,
    localparam A_SIZE               = D_SIZE - V_SHIFT,
    parameter [SIZE-1:0] H_BLANK_S  = 0'b 0,
    parameter [SIZE-1:0] H_SYNC_S   = 0'b 0,
    parameter [SIZE-1:0] H_SYNC_E   = 0'b 0,
    parameter [SIZE-1:0] H_BLANK_E  = 0'b 0,
    parameter [SIZE-1:0] V_BLANK_S  = 0'b 0,
    parameter [SIZE-1:0] V_SYNC_S   = 0'b 0,
    parameter [SIZE-1:0] V_SYNC_E   = 0'b 0,
    parameter [SIZE-1:0] V_BLANK_E  = 0'b 0
) (
    input wire clk,
    output wire blanking,
    output wire h_sync,
    output wire v_sync,
    output wire [A_SIZE-1:0] addr
);

    wire [SIZE-1:0] w_h_addr,
                    w_v_addr;
    wire [A_SIZE-1:0] w_addr;
    wire w_h_carry,
         w_v_carry,
         w_h_blank,
         w_v_blank;

    counter#(
        .SIZE(SIZE),
        .BLANK_S(H_BLANK_S),
        .SYNC_S(H_SYNC_S),
        .SYNC_E(H_SYNC_E),
        .BLANK_E(H_BLANK_E)
    ) h_counter (
        .clk(clk),
        .blank(w_h_blank),
        .sync(h_sync),
        .addr(w_h_addr),
        .carry(w_h_carry)
    );

    counter#(
        .SIZE(SIZE),
        .BLANK_S(V_BLANK_S),
        .SYNC_S(V_SYNC_S),
        .SYNC_E(V_SYNC_E),
        .BLANK_E(V_BLANK_E)
    ) v_counter (
        .clk(w_h_carry),
        .blank(w_v_blank),
        .sync(v_sync),
        .addr(w_v_addr),
        .carry(w_v_carry)
    );

    or_gate in_blanking(
        .a(w_h_blank),
        .b(w_v_blank),
        .y(blanking)
    );

    binary_counter#(
        .SIZE(A_SIZE)
    ) addr_counter(
        .clk(clk),
        .enable(~blanking),
        .rst(~w_v_carry),
        .q(w_addr)
    );

    assign addr = ((blanking) ? 0'b 0 : w_addr);
endmodule
    
