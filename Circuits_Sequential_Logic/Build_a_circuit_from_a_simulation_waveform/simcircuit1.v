//This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input a,
    input b,
    output q );//

    assign q = (a & b) ? 1 : 0; // Fix me

endmodule