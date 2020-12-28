//Create 8 D flip-flops with active high synchronous reset. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);

    integer i;
    
    always @(posedge clk) begin
        if (reset == 1) begin
            q[7:0] <= 8'b00000000;
        end
        else begin
            for (i = 0; i < 8; i++) begin
                q[i] <= d[i];
            end
        end
    end

endmodule
