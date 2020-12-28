module top_module (
    input clk,
    input d,
    output reg q
);
    reg pos_q,neg_q;
    
    always @(posedge clk) begin
        pos_q <= d;
    end

    always @(negedge clk) begin
        neg_q <= d;
    end

    always @(clk) begin
        if (clk) begin
            q = pos_q;
        end
        else begin
            q = neg_q;
        end
    end

endmodule