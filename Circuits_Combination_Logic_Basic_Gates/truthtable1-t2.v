
//Row     Inputs        Outputs
//number  x3  x2   x1   f
//0       0   0    0    0
//1       0   0    1    0
//2       0   1    0    1
//3       0   1    1    1
//4       1   0    0    0
//5       1   0    1    1
//6       1   1    0    0
//7       1   1    1    1

module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    always @(*) begin
        case ({x3,x2,x1})
            3'b000: f = 0;
            3'b001: f = 0;
            3'b010: f = 1;
            3'b011: f = 1;
            3'b100: f = 0;
            3'b101: f = 1;
            3'b110: f = 0;
            3'b111: f = 1;
            default: f = 0;
        endcase
    end

endmodule