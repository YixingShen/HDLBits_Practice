//This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    reg [3:0] q_tmp;

    assign q = q_tmp;

    always @(posedge clk) begin
        if (a == 1)
            q_tmp <= 4;
        else begin
            if (q_tmp < 6)
                q_tmp <= q_tmp + 1;
            else
                q_tmp <= 0;
        end
    end

endmodule
