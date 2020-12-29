//See Lfsr5 for explanations.

//Build a 32-bit Galois LFSR with taps at bit positions 32, 22, 2, and 1.

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end
        else begin
            q <= {(q[0] ^ 0),q[31:23],(q[22] ^ q[0]),q[21:3],(q[2] ^ q[0]),q[1] ^ q[0]};
            //q[31] <= q[0] ^ 0;
            //q[30] <= q[31];
            //...
            //q[28] <= q[23];
            //q[21] <= q[22] ^ q[0];
            //q[20] <= q[21];
            //...
            //q[2] <= q[3];
            //q[1] <= q[2] ^ q[0];
            //q[0] <= q[1] ^ q[0];
        end
    end

endmodule