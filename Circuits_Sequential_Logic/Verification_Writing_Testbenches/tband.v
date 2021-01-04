//You are given the following AND gate you wish to test:

//module andgate (
//    input [1:0] in,
//    output out
//);

//Write a testbench that instantiates this AND gate and tests all 4 input combinations, by generating the following timing diagram:

module top_module ( );
    reg [1:0] in;
    reg out;

    initial begin
        in = {1'b0,1'b0};

        #10 in = {1'b0,1'b1};
        #10 in = {1'b1,1'b0};
        #10 in = {1'b1,1'b1};
    end

    andgate inst1(.out(out), .in(in));

endmodule
