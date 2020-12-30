//See also: Serial receiver and datapath

//We want to add parity checking to the serial receiver. Parity checking adds one extra bit after each data byte.
//We will use odd parity, where the number of 1s in the 9 bits received must be odd. 
//For example, 101001011 satisfies odd parity (there are 5 1s), but 001001011 does not.

//Change your FSM and datapath to perform odd parity checking. Assert the done signal only if a byte is correctly received and its parity check passes.
//Like the serial receiver FSM, this FSM needs to identify the start bit, wait for all 9 (data and parity) bits, 
//then verify that the stop bit was correct. If the stop bit does not appear when expected, 
//the FSM must wait until it finds a stop bit before attempting to receive the next byte.

//You are provided with the following module that can be used to calculate the parity of the input stream (It's a TFF with reset).
//The intended use is that it should be given the input bit stream, and reset at appropriate times so it counts the number of 1 bits in each byte.

//module parity (
//    input clk,
//    input reset,
//    input in,
//    output reg odd);
//
//    always @(posedge clk)
//        if (reset) odd <= 0;
//        else if (in) odd <= ~odd;
//
//endmodule

//Note that the serial protocol sends the least significant bit first, and the parity bit after the 8 data bits.

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP_OK = 4, STOP_ERR = 5, STOP_ERR2OK = 6;
    parameter LOW = 0, HIGH = 1;
    parameter SUM_BIT_PARITY_ODD = 1;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;
    reg [7:0] out_byte_tmp;
    reg bit_sum;
    //reg odd;

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
                if (bit_count >= 4'd7)
                    next_state = PARITY;
                else begin
                    next_state = DATA;
                end
            end
            PARITY: begin
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
    
    assign done = (state == STOP_OK) && (bit_sum == SUM_BIT_PARITY_ODD) ? 1 : 0;

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

    //New: Add parity checking.
    always @(posedge clk) begin
        if (reset) begin
            bit_sum <= 1'b0;
        end
        else begin
            if ((next_state == DATA) || (next_state == PARITY)) begin
                if (in == HIGH)
                    bit_sum <= bit_sum + 1'b1;
            end
            else if (next_state == START) begin
                bit_sum <= 1'b0;
            end
        end
    end

endmodule
