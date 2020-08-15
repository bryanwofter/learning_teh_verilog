module pixel_counter#(
    parameter c=8
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
    i_rst <= rst;

binary_counter#(c) p_c (
    .clk(clk),
    .rst(i_rst),
    .q(q)
);

reg r_blanking;
reg r_syncing;

initial
begin
    r_blanking <= 0;
    r_syncing <= 0;
end

wire r_blanking_edge;
wire r_blanking_edge_not;
wire r_syncing_edge;
wire r_syncing_edge_not;

comparator#(c) cmp_s_blank(
    .d(q),
    .i(s_blank),
    .q(r_blanking_edge),
    .q_not(r_blanking_edge_not)
);

comparator#(c) cmp_s_sync(
    .d(q),
    .i(s_sync),
    .q(r_syncing_edge),
    .q_not(r_syncing_edge_not)
);

comparator#(c) cmp_r_blank (
    .d(q),
    .i(r_blank),
    .q(r_blanking_edge),
    .q_not(r_blanking_edge_not)
);

comparator#(c) cml_r_sync (
    .d(q),
    .i(r_sync),
    .q(r_syncing_edge),
    .q_not(r_syncing_edge_not)
);

always @(posedge r_blanking_edge)
    r_blanking <= ~(r_blanking);

always @(negedge r_blanking)
begin
    i_rst <= 0;
    i_rst <= 1;
end

always @(posedge r_syncing_edge)
    r_syncing <= ~(r_syncing);

always @(negedge r_blanking)
    i_rst <= 0;

always @(0 == q)
begin
    if (1 == rst)
        i_rst <= 1;
end

assign blank = r_blanking;
assign sync = r_syncing;
endmodule
