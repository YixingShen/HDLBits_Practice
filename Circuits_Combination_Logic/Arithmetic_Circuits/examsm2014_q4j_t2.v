module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    assign sum[4:0] = x[3:0] + y[3:0];
 
endmodule