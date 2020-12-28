//Create a 100-bit binary ripple-carry adder by instantiating 100 full adders. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit
//sum and carry out. To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. 
//cout[99] is the final carry-out from the last full adder, and is the carry-out you usually see.

//Hint...
//There are many full adders to instantiate. An instance array or generate statement would help here.

module myfulladder( 
    input a, b,
    input cin,
    output cout,
    output sum );

    assign {cout,sum} = a + b + cin;
    
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    generate
        myfulladder inst(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));

        for (i = 1; i < 100; i++) begin: myForLoop
            myfulladder inst(.a(a[i]), .b(b[i]), .cin(cout[i - 1]), .cout(cout[i]), .sum(sum[i]));
        end
    endgenerate

endmodule
