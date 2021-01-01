//The following diagram is a Mealy machine implementation of the 2's complementer. Implement using one-hot encoding.

//x = 7'b0110100 //52
//z = 7'b1001100 //76 = 8'b10000000 - 52
//x + z = 8'b1000_0000

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter A = 0, B = 1;

    reg [1:0] state, next_state;

    always @(*)begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk or posedge areset)begin
        if (areset)begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = (((state == A) && (x == 1)) || ((state == B) && (x == 0))) ? 1 : 0;

endmodule
