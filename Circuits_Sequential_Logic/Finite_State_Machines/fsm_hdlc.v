//Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets).
//Seeing exactly 6 consecutive 1s (i.e., 01111110) is a flag that indicate frame boundaries. 
//To avoid the data stream from accidentally containing flags, the sender inserts a zero after every 5 consecutive 1s which the receiver must detect and discard.
//We also need to signal an error if there are 7 or more consecutive 1s.

//Create a finite state machine to recognize these three sequences

//0111110 Signal a bit needs to be discarded (disc).
//01111110 Flag the beginningend of a frame (flag).
//01111111... Error (7 or more 1s) (err).
//When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

//Hint...
//Use a Moore state machine with around 10 states.

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter NONE = 0,
              COMBO1 = 1,
              COMBO2 = 2,
              COMBO3 = 3,
              COMBO4 = 4,
              COMBO5 = 5,
              COMBO6 = 6,
              ERROR = 7,
              DISCARD = 8,
              FLAG = 9;

    parameter LOW = 0, HIGH = 1;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            NONE:    next_state = (in == LOW)  ? NONE   : COMBO1;
            COMBO1:  next_state = (in == HIGH) ? COMBO2 : NONE;
            COMBO2:  next_state = (in == HIGH) ? COMBO3 : NONE;
            COMBO3:  next_state = (in == HIGH) ? COMBO4 : NONE;
            COMBO4:  next_state = (in == HIGH) ? COMBO5 : NONE;
            COMBO5:  next_state = (in == HIGH) ? COMBO6 : DISCARD;
            COMBO6:  next_state = (in == HIGH) ? ERROR  : FLAG;
            ERROR:   next_state = (in == HIGH) ? ERROR  : NONE;
            FLAG:    next_state = (in == HIGH) ? COMBO1 : NONE;
            DISCARD: next_state = (in == HIGH) ? COMBO1 : NONE;
            default: next_state = NONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= NONE;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign disc = (state == DISCARD) ? 1 : 0;
    assign flag = (state == FLAG) ? 1 : 0;
    assign err = (state == ERROR) ? 1 : 0;

endmodule
