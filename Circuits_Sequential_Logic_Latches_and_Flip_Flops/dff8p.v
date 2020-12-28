//Create 8 D flip-flops with active high synchronous reset. The flip-flops must be reset to 0x34 rather than zero.
// All DFFs should be triggered by the negative edge of clk.

module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);

    integer i;
    
    always @(negedge clk) begin
        if (reset == 1) begin
            q[7:0] <= 8'h34;
        end
        else begin
            for (i = 0; i < 8; i++) begin
                q[i] <= d[i];
            end
        end
    end
    
endmodule