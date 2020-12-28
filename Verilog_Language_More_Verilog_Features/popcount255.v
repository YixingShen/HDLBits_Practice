//A "population count" circuit counts the number of '1's in an input vector.
//Build a population count circuit for a 255-bit input vector.

//Hint...
//So many things to add... How about a for loop?

module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    always @(*) begin
        out = 8'b0;

        for (integer i = 0; i < 255; i++) begin
            out += in[i];
        end
    end

endmodule
