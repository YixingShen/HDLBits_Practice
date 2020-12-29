//Create 16 D flip-flops. It's sometimes useful to only modify parts of a group of flip-flops. 
//The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle.
//byteena[1] controls the upper byte d[15:8], while byteena[0] controls the lower byte d[7:0].

//resetn is a synchronous, active-low reset.

//All DFFs should be triggered by the positive edge of clk.

module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    integer i;
    
    always @(posedge clk) begin
        if (resetn == 0) begin
            if (byteena[1]) q[15:8] <= 8'h00;
            if (byteena[0]) q[7:0] <= 8'h00;
        end
        else begin
            if (byteena[0]) begin
                for (i = 0; i < 8; i++) begin
                    q[i] <= d[i];
                end
            end
            if (byteena[1]) begin
                for (i = 8; i < 16; i++) begin
                    q[i] <= d[i];
                end
            end
        end
    end
    
endmodule
