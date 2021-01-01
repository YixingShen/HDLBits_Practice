//Implement a Mealy-type finite state machine that recognizes the sequence "101" on an input signal named x.
//Your FSM should have an output signal, z, that is asserted to logic-1 when the "101" sequence is detected. 
//Your FSM should also have an active-low asynchronous reset. 
//You may only have 3 states in your state machine. Your FSM should recognize overlapping sequences.

//Mealy-type finite state machine
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter NONE = 0,
              S1 = 1,
              S2 = 2;

    parameter LOW = 0, HIGH = 1;

    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            NONE: next_state = (x == HIGH) ? S1 : NONE;
            S1:   next_state = (x == LOW)  ? S2 : S1;
            S2:   next_state = (x == HIGH) ? S1 : NONE;
            default: next_state = NONE;
        endcase
    end
    
    always @(posedge clk, negedge aresetn) begin
        if (aresetn == 0) begin
            state <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = ((state == S2) && x == 1) ? 1 : 0;

endmodule

//Moore-type finite state machine
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter NONE = 0,
              S1 = 1,
              S2 = 2,
              S3 = 3;

    parameter LOW = 0, HIGH = 1;

    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            NONE: next_state = (x == HIGH) ? S1 : NONE;
            S1:   next_state = (x == LOW)  ? S2 : S1;
            S2:   next_state = (x == HIGH) ? S3 : NONE;
            S3:   next_state = (x == HIGH) ? S1 : S2;

            default: next_state = NONE;
        endcase
    end
    
    always @(posedge clk, negedge aresetn) begin
        if (aresetn == 0) begin
            state <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = (state == S3) ? 1 : 0;

endmodule
