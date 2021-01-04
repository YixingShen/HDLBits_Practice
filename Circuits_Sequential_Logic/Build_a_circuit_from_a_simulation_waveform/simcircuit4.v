//This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    reg q_tmp;

    assign q = q_tmp;

    always @(*) begin
        case ({a,b,c,d})
            4'b0000: q_tmp = 0;
            4'b0001: q_tmp = 0;
            4'b0010: q_tmp = 1;
            4'b0011: q_tmp = 1;
            4'b0100: q_tmp = 1;
            4'b0101: q_tmp = 1;
            4'b0110: q_tmp = 1;
            4'b0111: q_tmp = 1;
            4'b1000: q_tmp = 0;
            4'b1001: q_tmp = 0;
            4'b1010: q_tmp = 1;
            4'b1011: q_tmp = 1;
            4'b1100: q_tmp = 1;
            4'b1101: q_tmp = 1;
            4'b1110: q_tmp = 1;
            4'b1111: q_tmp = 1;
            default: q_tmp = 0;
        endcase
    end

endmodule