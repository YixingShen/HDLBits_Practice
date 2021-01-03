//This is the fourth component in a series of five exercises that builds a complex counter out of several smaller circuits. 
//See the final exercise for the overall design.

//You may wish to do FSM: Enable shift register and FSM: Sequence recognizer first.

//We want to create a timer that:

//is started when a particular pattern (1101) is detected,
//shifts in 4 more bits to determine the duration to delay,
//waits for the counters to finish counting, and
//notifies the user and waits for the user to acknowledge the timer.
//In this problem, implement just the finite-state machine that controls the timer. The data path (counters and some comparators) are not included here.

//The serial data is available on the data input pin. When the pattern 1101 is received, 
//the state machine must then assert output shift_ena for exactly 4 clock cycles.

//After that, the state machine asserts its counting output to indicate it is waiting for the counters, 
//and waits until input done_counting is high.

//At that point, the state machine must assert done to notify the user the timer has timed out,
//and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

//The state machine should reset into a state where it begins searching for the input sequence 1101.

//Here is an example of the expected inputs and outputs. The 'x' states may be slightly confusing to read. 
//They indicate that the FSM should not care about that particular input signal in that cycle.
//For example, once a 1101 pattern is detected, 
//the FSM no longer looks at the data input until it resumes searching after everything else is done.

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
        
    parameter S = 0,
              S1 = 1,
              S11 = 2,
              S110 = 3,
              B0 = 4,
              B1 = 5,
              B2 = 6,
              B3 = 7,
              Count = 8,
              Wait = 9;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            B0,B1,B2,B3: begin
                shift_ena = 1;
                counting = 0;
                done = 0;
            end
            Count: begin
                shift_ena = 0;
                counting = 1;
                done = 0;
            end
            Wait: begin
                shift_ena = 0;
                counting = 0;
                done = 1;
            end
            default: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
        endcase
    end
    
    always @(*) begin
        case (state)
            S: begin
                next_state = data ? S1 : S;
            end
            S1: begin
                next_state = data ? S11 : S;
            end
            S11: begin
                next_state = data ? S11 : S110;
            end
            S110: begin
                next_state = data ? B0 : S;
            end
            B0: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = B3;
            end
            B3: begin
                next_state = Count;
            end
            Count: begin
                next_state = (!done_counting) ? Count : Wait;
            end
            Wait: begin
                next_state = (ack == 0) ? Wait : S;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S;
        end
        else begin
            state <= next_state;
        end
    end
    
endmodule