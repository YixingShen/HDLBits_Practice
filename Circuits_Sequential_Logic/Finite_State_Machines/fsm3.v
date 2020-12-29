//See also: State transition logic for this FSM

//The following is the state transition table for a Moore state machine with one input, one output,
//and four states. Implement this state machine. Include an asynchronous reset that resets the FSM to state A.

//State    Next state    Output
//         in=0  in=1
//  A      A     B       0
//  B      C     B       0
//  C      A     D       0
//  D      C     B       1

module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A = 4'b0001,B = 4'b0010,C = 4'b0100,D = 4'b1000;
    reg [3:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
            default: next_state = A;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign out = (state == D) ? 1 : 0;
    
endmodule
