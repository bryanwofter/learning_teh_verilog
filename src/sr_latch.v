module sr_latch (
    input wire s,
    input wire r,
    output wire q,
    output wire q_not
);

assign q = ~(r | q_not);
assign q_not = ~(s | q);
endmodule
