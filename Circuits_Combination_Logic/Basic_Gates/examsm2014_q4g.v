module top_module (
    input in1,
    input in2,
    input in3,
    output out);

    wire in1_in2_xnor;
    assign in1_in2_xnor = ~(in1 ^ in2);
    assign out = in1_in2_xnor ^ in3;
    
endmodule
