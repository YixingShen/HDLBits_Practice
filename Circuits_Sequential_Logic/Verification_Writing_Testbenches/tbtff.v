//You are given a T flip-flop module with the following declaration:

//module tff (
//    input clk,
//    input reset,   // active-high synchronous reset
//    input t,       // toggle
//    output q
//);
//Write a testbench that instantiates one tff and will reset the T flip-flop then toggle it to the "1" state.

module top_module ();
    parameter period = 10;

    reg clk, reset, t, q;

    initial begin
        clk = 0;
        reset = 0;
        t = 0;
        
        #20 reset = 1;
        #20 reset = 0;
    end

    always begin
        #(period/2) clk = ~clk;
    end
    
    always @(negedge clk) begin
        t <= ~t;
    end
    
    tff inst1(.clk(clk),.reset(reset),.t(t),.q(q));
    
endmodule