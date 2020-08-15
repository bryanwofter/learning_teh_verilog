module d_flipflop (
    input wire d,
    input wire clk,
    input wire rst,
    output wire q,
    output wire q_not
);

reg r_q;

always @(posedge clk, negedge rst)
begin
    if (~rst)
        r_q <= 1'b0;
    else
        r_q <= d;
end

assign q = r_q;
assign q_not = ~(r_q);
endmodule
