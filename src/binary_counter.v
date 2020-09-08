module binary_counter#(
    parameter SIZE = 8
) (
    input wire clk,
    input wire enable,
    input wire rst,
    output wire [SIZE-1:0] q
);
reg [SIZE-1:0] r_q;

always @(posedge clk) begin
    if (~rst)
        r_q <= 0;
    else if (enable)
        r_q <= r_q + 1;
end

assign q = r_q;
endmodule
