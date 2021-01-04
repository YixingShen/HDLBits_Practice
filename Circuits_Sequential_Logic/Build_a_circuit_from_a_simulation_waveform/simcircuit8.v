//This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    reg q_tmp;

    assign p = clock ? a : p;
    assign q = q_tmp;

    always @(negedge clock) begin
        q_tmp <= a;
    end
    
endmodule