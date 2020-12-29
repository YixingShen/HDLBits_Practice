//A "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 3-bit input vector.

module top_module( 
    input [2:0] in,
    output [1:0] out );

    reg [1:0] count;
    integer i;

    always @(*) begin
        count = 0;

        for (i = 0; i < 3; i++) begin
            count += in[i];
        end
    end
    
    assign out = count;

endmodule
