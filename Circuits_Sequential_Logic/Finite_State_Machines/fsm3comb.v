//The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.

//Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. Given the current state (state), compute the next_state and output (out) based on the state transition table.

//State    Next state    Output
//         in=0    in=1
//  A        A    B       0
//  B        C    B       0
//  C        A    D       0
//  D        C    B       1

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    reg [1:0] next_state_t;
    
    assign next_state = next_state_t;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        // State transition logic
        case (state)
            A: next_state_t = (in == 0) ? A : B;
            B: next_state_t = (in == 0) ? C : B;
            C: next_state_t = (in == 0) ? A : D;
            D: next_state_t = (in == 0) ? C : B;
            default: next_state_t = A;
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D) ? 1 : 0;

endmodule