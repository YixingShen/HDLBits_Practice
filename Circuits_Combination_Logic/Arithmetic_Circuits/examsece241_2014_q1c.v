//Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0]. These numbers are added to produce s[7:0]. 
//Also compute whether a (signed) overflow has occurred.

//Hint...
//A signed overflow occurs when adding two positive numbers produces a negative result, 
//or adding two negative numbers produces a positive result. There are several methods to detect overflow:
//It could be computed by comparing the signs of the input and output numbers, or derived from the carry-out of bit n and n-1.

module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    wire is_b7_same;
    wire is_signed;
    
    assign s = a + b;
    assign is_signed = a[7];
    assign is_b7_same = (a[7] == b[7]);
    assign overflow = is_b7_same & ((is_signed & ~s[7]) | (~is_signed & s[7]));

endmodule