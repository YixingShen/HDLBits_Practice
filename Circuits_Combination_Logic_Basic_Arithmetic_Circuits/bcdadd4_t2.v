//You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.
//
//module bcd_fadd {
//    input [3:0] a,
//    input [3:0] b,
//    input     cin,
//    output   cout,
//    output [3:0] sum );
//Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. Your adder should add two 4-digit BCD numbers 
//(packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.

module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [4:0] cin_next;
    
    assign cin_next[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin: MyForLoop
            bcd_fadd inst1(.a(a[3+i*4:i*4]),
                           .b(b[3+i*4:i*4]),
                           .cin(cin_next[i]),
                           .cout(cin_next[i + 1]),
                           .sum(sum[3+i*4:i*4]));
        end
    endgenerate
    
    assign cout = cin_next[4];

endmodule
