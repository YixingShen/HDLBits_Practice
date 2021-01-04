//You are provided a module with the following declaration:

//module dut ( input clk ) ;
//Write a testbench that creates one instance of module dut (with any instance name), 
//and create a clock signal to drive the module's clk input.
//The clock has a period of 10 ps. The clock should be initialized to zero with its first transition being 0 to 1.

`timescale 1ps / 1ps

module top_module ( );
    parameter period = 10;
    reg clk;

    initial begin
        clk = 0;
    end

    always begin
        #(period/2) clk = ~clk;
    end

    dut inst1(.clk(clk));

endmodule