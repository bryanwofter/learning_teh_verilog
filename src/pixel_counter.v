module pixel_counter (
    input wire clk,
    input wire rst,
    output wire [9:0] q,
    output wire blank,
    output wire sync
);

reg i_rst;

always @(posedge rst, negedge rst)
begin
    assign i_rst = rst;
end

binary_counter#(10) p_c (
    .clk(clk),
    .rst(rst),
    .q(q)
);

wire r_ignore;
wire r_400;
wire r_410;
wire r_484;
wire r_528;

comparator cmp_400 (
    .d(q),
    .i(10'b0110010000),
    .q(r_400),
    .q_not(r_ignore)
);

sr_latch sr_blank (
    .s(r_400),
    .r(r_528),
    .q(blank),
    .q_not(r_ignore)
);

sr_latch sr_sync (
    .s(r_410),
    .r(r_484),
    .q(sync),
    .q_not(r_ignore)
);
endmodule
