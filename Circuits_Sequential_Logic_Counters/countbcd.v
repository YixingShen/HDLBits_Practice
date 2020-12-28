//Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is encoded using 4 bits: q[3:0] is the ones digit,
//q[7:4] is the tens digit, etc. For digits [3:1], also output an enable signal indicating when each of the upper three digits should be incremented.

//You may want to instantiate or modify some one-digit decade counters.

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg [15:0] count;
    wire [3:0] cond;

    assign q = count;

    assign cond[0] = count[3:0] == 9;
    assign cond[1] = count[7:4] == 9;
    assign cond[2] = count[11:8] == 9;
    assign cond[3] = count[15:12] == 9;

    assign ena[1] = cond[0];
    assign ena[2] = cond[1] & cond[0];
    assign ena[3] = cond[2] & cond[1] & cond[0];

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end
        else begin
            count[3:0] <= count[3:0] + 1;

            if (cond[0]) begin
                count[3:0] <= 0;
                count[7:4] <= count[7:4] + 1;
            end
            
            if (cond[0] & cond[1]) begin
                count[7:4] <= 0;
                count[11:8] <= count[11:8] + 1;
            end
            
            if (cond[0] & cond[1] & cond[2]) begin
                count[11:8] <= 0;
                count[15:12] <= count[15:12] + 1;
            end
            
            if (cond[0] & cond[1] & cond[2] & cond[3]) begin
                count[15:12] <= 0;
            end
        end
    end

endmodule
