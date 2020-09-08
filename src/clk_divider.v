module clk_divider (
    input wire clk,
    output wire q
);
reg ff = 0;

always @(posedge clk)
    ff <= ~ff;

assign q = ff;
endmodule
