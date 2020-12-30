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
    parameter IDLE = 0,
              START = 1,
              BIT0 = 2,
              BIT1 = 3,
              BIT2 = 4,
              BIT3 = 5,
              BIT4 = 6,
              BIT5 = 7,
              BIT6 = 8,
              BIT7 = 9,
              STOP_OK = 10,
              STOP_ERR = 11,
              STOP_ERR2OK = 12;
    parameter LOW = 0, HIGH = 1;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == LOW) //Start Bit is Detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = BIT0;
            end
            BIT0: begin
                next_state = BIT1;
            end
            BIT1: begin
                next_state = BIT2;
            end
            BIT2: begin
                next_state = BIT3;
            end
            BIT3: begin
                next_state = BIT4;
            end
            BIT4: begin
                next_state = BIT5;
            end
            BIT5: begin
                next_state = BIT6;
            end
            BIT6: begin
                next_state = BIT7;
            end
            BIT7: begin
                if (in == HIGH) //Stop Bit is Detected
                    next_state = STOP_OK;
                else //Stop Bit Error
                    next_state = STOP_ERR;
            end
            STOP_OK: begin
                if (in == LOW) //Start Bit is Detected
                    next_state = START;
                else //Idle is Detected 
                    next_state = IDLE;
            end
            STOP_ERR: begin
                if (in == HIGH)
                    next_state = STOP_ERR2OK;
                else
                    next_state = STOP_ERR;
            end
            STOP_ERR2OK: begin
                if (in == LOW) //Start Bit is Detected
                    next_state = START;
                else //Idle is Detected 
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    assign done = (state == STOP_OK) ? 1 : 0;

endmodule
