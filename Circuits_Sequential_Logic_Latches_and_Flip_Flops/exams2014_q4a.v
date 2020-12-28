module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);

    wire mux1_o,mux2_o;
    
    assign mux1_o = (E == 1) ? w : Q;
    assign mux2_o = (L == 1) ? R : mux1_o;

    always @(posedge clk) begin
        Q <= mux2_o;
    end

endmodule
