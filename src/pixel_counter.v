module pixel_counter#(
    parameter c
) (
    input wire clk,
    input wire rst,
    input wire [c-1:0] s_blank,
    input wire [c-1:0] s_sync,
    input wire [c-1:0] r_sync,
    input wire [c-1:0] r_blank,
    output wire [c-1:0] q,
    output wire blank,
    output wire sync
);

reg i_rst;

always @(posedge rst, negedge rst)
begin
    assign i_rst = rst;
end

binary_counter#(c) p_c (
    .clk(clk),
    .rst(rst),
    .q(q)
);

wire r_ignore;
wire r_s_blank;
wire r_s_sync;
wire r_r_sync;
wire r_r_blank;

comparator cmp_s_blank (
    .d(q),
    .i(s_blank),
    .q(r_s_blank),
    .q_not(r_ignore)
);

comparator cmp_r_blank (
    .d(q),
    .i(r_blank),
    .q(r_r_blank),
    .q_not(r_ignore)
);

sr_latch sr_blank (
    .s(r_s_blank),
    .r(r_r_blank),
    .q(blank),
    .q_not(r_ignore)
);

comparator cmp_s_sync (
    .d(q),
    .i(s_sync),
    .q(r_s_sync),
    .q_not(r_ignore)
);

comparator cmp_r_sync (
    .d(q),
    .i(r_sync),
    .q(r_r_sync),
    .q_not(r_ignore)
);

sr_latch sr_sync (
    .s(r_s_sync),
    .r(r_r_sync),
    .q(sync),
    .q_not(r_ignore)
);
endmodule
