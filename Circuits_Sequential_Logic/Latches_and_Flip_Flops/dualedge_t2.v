module top_module (
    input clk,
    input d,
    output q
);
    reg pos_q,neg_q;
    
    assign q = clk ? pos_q : neg_q;

    always @(posedge clk) begin
        pos_q <= d;
    end

    always @(negedge clk) begin
        neg_q <= d;
    end

endmodule