//Create 8 D flip-flops with active high asynchronous reset. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    integer i;
    
    always @(posedge clk or posedge areset) begin
        if (areset == 1) begin
            q[7:0] <= 8'h00;
        end
        else begin
            for (i = 0; i < 8; i++) begin
                q[i] <= d[i];
            end
        end
    end
 
endmodule
