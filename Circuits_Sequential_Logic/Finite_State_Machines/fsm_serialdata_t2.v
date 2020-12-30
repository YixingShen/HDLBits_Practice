//See also: Serial receiver

//Now that you have a finite state machine that can identify when bytes are correctly received in a serial bitstream,
//add a datapath that will output the correctly-received data byte. out_byte needs to be valid when done is 1, and is don't-care otherwise.

//Note that the serial protocol sends the least significant bit first.

//Hint...
//The serial bitstream needs to be shifted in one bit at a time, then read out in parallel.

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
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
    reg [7:0] out_byte_tmp;

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
    
    always @(posedge clk)begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
           state <= next_state; 
        end
    end
    
    assign done = (state == STOP_OK) ? 1 : 0;

    // New: Datapath to latch input bits.
    assign out_byte = done ? out_byte_tmp : 8'h00;
    
    always @(posedge clk)begin
        if (reset) begin
            out_byte_tmp = 8'h00;
        end
        else begin
            if ((next_state > START) && (next_state < STOP_OK))
                out_byte_tmp <= {in,out_byte_tmp[7:1]};
        end
    end

endmodule
