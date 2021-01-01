//You are to design a one-input one-output serial 2's complementer Moore state machine. 
//The input (x) is a series of bits (one per clock cycle) beginning with the least-significant bit of the number, 
//and the output (Z) is the 2's complement of the input. The machine will accept input numbers of arbitrary length. 
//The circuit requires an asynchronous reset. The conversion begins when Reset is released and stops when Reset is asserted.


//x = 7'b0110100 //52
//z = 7'b1001100 //76 = 8'b10000000 - 52
//x + z = 8'b1000_0000

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter NONE = 0, S1 = 1, S2 = 2;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset)begin
        if (areset)begin
            state <= NONE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*)begin
        case (state)
            NONE: next_state = x ? S1 : NONE;
            S1:   next_state = x ? S2 : S1;
            S2:   next_state = x ? S2 : S1;
            default: next_state = NONE;
        endcase
    end
    
    assign z = (state == S1) ? 1 : 0;

endmodule
