module counter#(
    parameter SIZE =                1'b 1,
    parameter [SIZE-1:0] BLANK_S =  1'b 0,
    parameter [SIZE-1:0] SYNC_S =   1'b 0,
    parameter [SIZE-1:0] SYNC_E =   1'b 0,
    parameter [SIZE-1:0] BLANK_E =  1'b 0
) (
    input wire clk,
    output wire blank,
    output wire sync,
    output wire [SIZE-1:0] addr,
    output wire carry
);
reg [SIZE-1:0] r_pos = 1'b 0;

reg ff_blank = 1'b 0,
    ff_sync =  1'b 0;

always @(posedge clk) begin
    r_pos <= r_pos + 1'b 1;
    case (r_pos)
        BLANK_S: ff_blank <= 1;
        SYNC_S: ff_sync <= 1;
        SYNC_E: ff_sync <= 0;
        BLANK_E: begin
            r_pos <= 1'b 0;
            ff_blank <= 1'b 0;
        end
    endcase
end

assign addr = r_pos;
assign blank = ff_blank;
assign sync = ff_sync;
assign carry = BLANK_E == addr;
endmodule
