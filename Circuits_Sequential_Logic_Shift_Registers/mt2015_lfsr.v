//Taken from 2015 midterm question 5. See also the first part of this question: mt2015_muxdff

//Write the Verilog code for this sequential circuit (Submodules are ok, but the top-level must be named top_module).
//Assume that you are going to implement the circuit on the DE1-SoC board. Connect the R inputs to the SW switches, 
//connect Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.

//Hint...
//This circuit is an example of a Linear Feedback Shift Register (LFSR). 
//A maximum-period LFSR can be used to generate pseudorandom numbers, as it cycles through 2n-1 combinations before repeating. 
//The all-zeros combination does not appear in this sequence.

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    wire [2:0] R;
    wire L,clk;
    reg [2:0] Q;
    
    assign R = SW;
    assign {L,clk} = KEY;
    assign LEDR = Q;

    always @(posedge clk) begin
        Q[0] <= (L == 1) ? R[0] : Q[2];
        Q[1] <= (L == 1) ? R[1] : Q[0];
        Q[2] <= (L == 1) ? R[2] : (Q[1] ^ Q[2]);
    end
    
endmodule