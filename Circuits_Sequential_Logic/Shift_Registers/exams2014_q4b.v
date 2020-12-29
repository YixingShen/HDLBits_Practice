//Write a top-level Verilog module (named top_module) for the shift register, assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your top-level module. Assume that you are going to implement the circuit on the DE2 board.

//Connect the R inputs to the SW switches,
//clk to KEY[0],
//E to KEY[1],
//L to KEY[2], and
//w to KEY[3].
//Connect the outputs to the red lights LEDR[3:0].
//(Reuse your MUXDFF from exams/2014_q4a.)

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    wire [3:0] R;
    wire w,L,E,clk;
    reg [3:0] Q;
    
    assign R = SW;
    assign {w,L,E,clk} = KEY;
    assign LEDR = Q;
    
    MUXDFF inst1(.w(w),   .L(L),.E(E),.clk(clk),.R(R[3]),.out(Q[3]));
    MUXDFF inst2(.w(Q[3]),.L(L),.E(E),.clk(clk),.R(R[2]),.out(Q[2]));
    MUXDFF inst3(.w(Q[2]),.L(L),.E(E),.clk(clk),.R(R[1]),.out(Q[1]));
    MUXDFF inst4(.w(Q[1]),.L(L),.E(E),.clk(clk),.R(R[0]),.out(Q[0]));

endmodule

module MUXDFF (input w, input L, input E, input clk, input R, output out);
    reg Q;
    wire mux1_o,mux2_o;
    
    assign out = Q;
    assign mux1_o = (E == 1) ? w : Q;
    assign mux2_o = (L == 1) ? R : mux1_o;

    always @(posedge clk) begin
        Q <= mux2_o;
    end

endmodule