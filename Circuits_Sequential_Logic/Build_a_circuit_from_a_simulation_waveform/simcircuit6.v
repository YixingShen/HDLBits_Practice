//This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input [2:0] a,
    output [15:0] q ); 
    
    parameter a0 = 16'h1232;
    parameter a1 = 16'haee0;
    parameter a2 = 16'h27d4;
    parameter a3 = 16'h5a0e;
    parameter a4 = 16'h2066;
    parameter a5 = 16'h64ce;
    parameter a6 = 16'hc526;
    parameter a7 = 16'h2f19;

    always @(*) begin
        case (a)
            0: q = a0;
            1: q = a1;
            2: q = a2;
            3: q = a3;
            4: q = a4;
            5: q = a5;
            6: q = a6;
            7: q = a7;
            default: q = 0;
        endcase
    end

endmodule