//Build a 4-bit shift register (right shift), with asynchronous reset, synchronous load, and enable.

//areset: Resets shift register to zero.
//load: Loads shift register with data[3:0] instead of shifting.
//ena: Shift right (q[3] becomes zero, q[0] is shifted out and disappears).
//q: The contents of the shift register.
//If both the load and ena inputs are asserted (1), the load input has higher priority.

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            q <= 0;
        end
        else begin
            if (load) begin
                q <= data;
            end
            else if (ena) begin
                q[0] <= q[1]; //right shift
                q[1] <= q[2];
                q[2] <= q[3];
                q[3] <= 0;
            end
        end
    end

endmodule
