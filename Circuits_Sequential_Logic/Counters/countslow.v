//Build a decade counter that counts from 0 through 9, inclusive, with a period of 10.
//The reset input is synchronous, and should reset the counter to 0. 
//We want to be able to pause the counter rather than always incrementing every clock cycle, 
//so the slowena input indicates when the counter should increment.

//Hint...
//This is a regular decade counter with an enable control signal

module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    reg [3:0] count;
    
    assign q = count;
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end
        else begin
            if (slowena) begin 
                if (count < 9)
                    count <= count + 1;
                else
                    count <= 0;
            end
        end
    end

endmodule
