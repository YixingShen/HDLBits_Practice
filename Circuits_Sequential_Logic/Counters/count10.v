//Make a decade counter that counts 1 through 10, inclusive. The reset input is synchronous, and should reset the counter to 1.

module top_module (
    input clk,
    input reset,
    output [3:0] q);

    reg [3:0] count;
    
    assign q = count;

    always @(posedge clk) begin
        if (reset) begin
            count = 1;
        end
        else begin
            if (count < 10) 
                count <= count + 1;
            else
                count <= 1;
        end
    end
    
endmodule