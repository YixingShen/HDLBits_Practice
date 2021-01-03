//This is the fifth component in a series of five exercises that builds a complex counter out of several smaller circuits. 
//You may wish to do the four previous exercises first (counter, sequence recognizer FSM, FSM delay, and combined FSM).

//We want to create a timer with one input that:

//is started when a particular input pattern (1101) is detected,
//shifts in 4 more bits to determine the duration to delay,
//waits for the counters to finish counting, and
//notifies the user and waits for the user to acknowledge the timer.
//The serial data is available on the data input pin. When the pattern 1101 is received, the circuit must then shift in the next 4 bits,
//most-significant-bit first. These 4 bits determine the duration of the timer delay. I'll refer to this as the delay[3:0].

//After that, the state machine asserts its counting output to indicate it is counting.
//The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles.
//e.g., delay=0 means count 1000 cycles, and delay=5 means count 6000 cycles. Also output the current remaining time. 
//This should be equal to delay for 1000 cycles, then delay-1 for 1000 cycles, and so on until it is 0 for 1000 cycles. 
//When the circuit isn't counting, the count[3:0] output is don't-care (whatever value is convenient for you to implement).

//At that point, the circuit must assert done to notify the user the timer has timed out, 
//and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

//The circuit should reset into a state where it begins searching for the input sequence 1101.

//Here is an example of the expected inputs and outputs. 
//The 'x' states may be slightly confusing to read. 
//They indicate that the FSM should not care about that particular input signal in that cycle.
//For example, once the 1101 and delay[3:0] have been read,
//the circuit no longer looks at the data input until it resumes searching after everything else is done.
//In this example, the circuit counts for 2000 clock cycles because the delay[3:0] value was 4'b0001. 
//The last few cycles starts another count with delay[3:0] = 4'b1110, which will count for 15000 cycles.

//Hint...
//The hardware should be approximately the FSM from Exams/review2015_fsm, the counter from Exams/review2015_count1k, 
//and the shift register+counter from Exams/review2015_shiftcount. You'll probably need a few more comparators here.
//It's ok to have all the code in a single module if the components are in their own always blocks, 
//as long as it's clear which blob of code corresponds to which hardware block. 
//Don't merge multiple always blocks together, as that's hard to read and error-prone.

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output reg counting,
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

    reg [3:0] delay;
    reg [3:0] state, next_state;
    reg [9:0] count_cycles;
    reg done_counting;
    reg shift_ena;
    
    assign count = delay;
    assign done_counting = (delay == 0) && (count_cycles == 999);

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
            delay <= 0;
            count_cycles <= 0;
        end
        else begin
            if (shift_ena) begin
                delay <= {delay[2:0],data};
                count_cycles <= 0;
            end
            else if (counting) begin
                if (delay >= 0) begin
                    if (count_cycles < 999) begin //0,1,2,..,999
                        count_cycles <= count_cycles + 1;
                    end
                    else begin
                        count_cycles <= 0;
                        
                        if (delay >= 1)
                            delay <= delay - 1;
                    end
                end
            end
        end
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