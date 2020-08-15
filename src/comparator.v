module comparator#(
    parameter s=8
) (
    input wire [s-1:0] d,
    input wire [s-1:0] i,
    output wire q,
    output wire q_not
);

assign q = (d == i);
assign q_not = ~(q);
endmodule
