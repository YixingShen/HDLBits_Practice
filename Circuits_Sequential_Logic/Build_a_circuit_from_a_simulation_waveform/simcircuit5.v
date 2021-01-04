//This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
   
    reg [3:0] q_tmp;
    
    assign q = q_tmp;
    
    always @(*) begin
        if (c == 0)
            q_tmp = b;
        else if (c == 1)
            q_tmp = e;
        else if (c == 2)
            q_tmp = a;
        else if (c == 3)
            q_tmp = d;
        else
            q_tmp = 4'hf;
    end
    
endmodule