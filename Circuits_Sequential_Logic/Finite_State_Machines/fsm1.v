//This is a Moore state machine with two states, one input, and one output. 
//Implement this state machine. Notice that the reset state is B.

//This exercise is the same as fsm1s, but using asynchronous reset.

//Hint...
//Yes, there are ways to do this other than writing an FSM. But that wasn't the point of this exercise.
//Hint...
//This is a TFF with the T input inverted.

module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        if (state == B) begin
            next_state = (in == 0) ? A : B;
        end
        else begin
            next_state = (in == 0) ? B : A;
        end
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == B) ? 1 : 0;

endmodule