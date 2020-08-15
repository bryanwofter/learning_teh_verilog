module binary_counter#(
    parameter s=8
) (
    input wire clk,
    input wire rst,
    output wire [s-1:0] q
);

reg [s-1:0] r_count;

always @(posedge clk, negedge rst)
begin
    if (~rst)
        r_count <= 0;
    else
        r_count <= r_count + 1;
end

assign q = r_count;
endmodule
