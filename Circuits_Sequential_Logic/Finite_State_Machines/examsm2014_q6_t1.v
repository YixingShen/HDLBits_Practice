//Consider the state machine shown below, which has one input w and one output z.

//Implement the state machine. (This part wasn't on the midterm, but coding up FSMs is good practice).

module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A = 0,
              B = 1,
              C = 2,
              D = 3,
              E = 4,
              F = 5;

    reg [3:1] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = ((state == E) || (state == F)) ? 1 : 0;
    
endmodule
