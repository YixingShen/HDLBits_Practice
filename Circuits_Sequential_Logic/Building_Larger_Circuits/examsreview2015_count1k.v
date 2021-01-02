//Build a counter that counts from 0 to 999, inclusive, with a period of 1000 cycles. 
//The reset input is synchronous, and should reset the counter to 0.

module top_module (
    input clk,
    input reset,
    output [9:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            if (q < 999)
                q <= q + 1;
            else
                q <= 0;
        end
    end

endmodule
