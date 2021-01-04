//The waveform below sets clk, in, and s:

//Module q7 has the following declaration:

//module q7 (
//    input clk,
//    input in,
//    input [2:0] s,
//    output out
//);

//Write a testbench that instantiates module q7 and generates these input signals exactly as shown in the waveform above.

module top_module();

    parameter period = 10;
    reg clk;
    reg [2:0] s;
    reg in;
    reg out;

    integer i;
    
    initial begin
        clk = 0;
        i = 0;
        s = 2;
        in = 0;
    end

    always begin
        #(period/2) clk = ~clk;
    end
    
    always @(negedge clk) begin 
        if (i == 0) begin
            s = 6; in = 0;
        end
        if (i == 1) begin
            s = 2; in = 1;
        end
        if (i == 2) begin
            s = 7; in = 0;
        end
        if (i == 3) begin
            s = 0; in = 1;
        end
        if (i == 6) begin
            s = 0; in = 0;
        end

        i <= i + 1;
    end
    
    q7 inst1(.clk(clk), .in(in), .s(s), .out(out));

endmodule
