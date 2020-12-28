//Assume that you want to implement hierarchical Verilog code for this circuit,
//using three instantiations of a submodule that has a flip-flop and multiplexer in it.
//Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.

module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    wire d;
    
    assign d = (L == 1) ? r_in : q_in;
        
    always @(posedge clk) begin
        Q <= d;
    end
    
endmodule