//In many (older) serial communications protocols, each data byte is sent along with a start bit and a stop bit, 
//to help the receiver delimit bytes from the stream of bits. 
//One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). 
//The line is also at logic 1 when nothing is being transmitted (idle).

//Design a finite state machine that will identify when bytes have been correctly received when given a stream of bits. 
//It needs to identify the start bit, wait for all 8 data bits, then verify that the stop bit was correct. 
//If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, STOP_ERR = 4;
    parameter LOW = 0, HIGH = 1;

    reg [2:0] state, next_state;
    reg [3:0] data_count;

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == LOW) //Start Bit is Detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (data_count >= 4'd7)
                    if (in == HIGH) //Stop Bit is Detected
                        next_state = STOP;
                    else //Stop Bit Error
                        next_state = STOP_ERR;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == LOW) //Start Bit is Detected
                    next_state = START;
                else //Idle is Detected 
                    next_state = IDLE;
            end
            STOP_ERR: begin
                if (in == HIGH)
                    next_state = IDLE;
                else
                    next_state = STOP_ERR;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_count <= 4'd0;
        end
        else begin
            state <= next_state;

            if (state == DATA)
                data_count <= data_count + 4'd1;
            else
                data_count <= 4'd0;
        end
    end

    assign done = (state == STOP) ? 1 : 0;

endmodule
