module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] Q;
    
    assign out = Q[3];
    
    always @(posedge clk) begin
        if (resetn == 0) begin
            Q <= 0;
        end
        else begin
            Q <= {Q[2:0],in}; 
        end
    end
    
endmodule