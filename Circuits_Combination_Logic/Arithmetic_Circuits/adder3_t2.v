//Now that you know how to build a full adder, make 3 instances of it to create a 3-bit binary ripple-carry adder. 
//The adder adds two 3-bit numbers and a carry-in to produce a 3-bit sum and carry out. To encourage you to actually 
//instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. cout[2] is the final 
//carry-out from the last full adder, and is the carry-out you usually see.

module fadd( 
    input a, b, cin,
    output cout, sum );
    
    assign {cout,sum} = a + b + cin;
    
endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire [2:0] cin_t;
    
    assign cin_t = {cout[1:0], cin};

    genvar i;
    generate
        for (i = 0; i < 3; i++) begin: myForLoop
            fadd inst(.a(a[i]),
                      .b(b[i]),
                      .cin(cin_t[i]),
                      .cout(cout[i]),
                      .sum(sum[i]));
        end
    endgenerate

endmodule

