//Create a 100-bit binary adder. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.

//Expected solution length: Around 1 line.

//Hint...
//There are too many full adders to instantiate, but behavioural code works well here. Also see the solution to Adder.

module fadd( 
    input a, b, cin,
    output cout, sum );
    
    assign {cout,sum} = a + b + cin;
    
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire [100:0] cin_next;
    
    assign cin_next[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 100; i++) begin: MyForLoop
            fadd inst1(.a(a[i]),
                       .b(b[i]),
                       .cin(cin_next[i]),
                       .cout(cin_next[i + 1]),
                       .sum(sum[i]));
        end
    endgenerate
    
    assign cout = cin_next[100];

endmodule