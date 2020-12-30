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
    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, STOP_ERR = 4;
    parameter LOW = 0, HIGH = 1;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;
    reg [7:0] out_byte_tmp;

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0) //Start Bit is Detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count >= 4'd7)
                    if (in == HIGH) //Stop Bit is Detected
                        next_state = STOP;
                    else //Stop Bit Error
                        next_state = STOP_ERR;
                else begin
                    next_state = DATA;
                end
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
            bit_count <= 4'd0;
        end
        else begin
            state <= next_state;

            if (state == DATA) begin
                bit_count <= bit_count + 4'd1;
            end
            else begin
                bit_count <= 4'd0;
            end
        end
    end

    assign done = (state == STOP) ? 1 : 0;

    // New: Datapath to latch input bits.
    assign out_byte = done ? out_byte_tmp : 8'h00;
    
    always @(posedge clk) begin
        if (reset) begin
            out_byte_tmp <= 8'h00;
        end
        else begin
            if (next_state == DATA) begin
                out_byte_tmp <= {in,out_byte_tmp[7:1]};
            end
        end
    end
    
endmodule
