//This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.

//This exercise is the same as fsm2s, but using asynchronous reset

//Hint...
//Yes, there are ways to do this other than writing an FSM. But that wasn't the point of this exercise.
//Hint...
//This is a JK flip-flop.

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if (state == OFF) begin
           next_state = (j == 1) ? ON : OFF;
        end
        else begin
           next_state = (k == 1) ? OFF : ON;
        end
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == ON) ? 1 : 0;

endmodule
