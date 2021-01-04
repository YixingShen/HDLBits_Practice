//This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input clk,
    input a,
    output q );
        
    reg q_tmp;
    
    assign q = q_tmp;

    always @(posedge clk) begin
        q_tmp <= ~a;
    end

endmodule