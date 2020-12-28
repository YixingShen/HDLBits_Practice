module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    integer i;
    reg [31:0] q;

    always @(posedge clk) begin
        q <= in;

        if (reset) begin
            out <= 0;
        end
        else begin
            for (i = 0; i < 32; i++) begin
                out[i] <= (q[i] == 1) & (in[i] == 0) | out[i];
            end
        end
    end
endmodule
