//For each bit in an 8-bit vector, detect when the input signal changes from one clock cycle to the next (detect any edge).
//The output bit should be set the cycle after a 0 to 1 transition occurs.

module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    integer i;
    reg [7:0] q;
    
    always @(posedge clk) begin
        q <= in;

        for (i = 0; i < 8; i++) begin
            anyedge[i] <= (q[i] != in[i]);
        end
    end
    
endmodule