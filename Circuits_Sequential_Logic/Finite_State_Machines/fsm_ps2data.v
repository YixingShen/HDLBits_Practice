//See also: PS/2 packet parser.

//Now that you have a state machine that will identify three-byte messages in a PS/2 byte stream, 
//add a datapath that will also output the 24-bit (3 byte) message whenever a packet is received 
//(out_bytes[23:16] is the first byte, out_bytes[15:8] is the second byte, etc.).

//out_bytes needs to be valid whenever the done signal is asserted. 
//You may output anything at other times (i.e., don't-care).

//Hint...
//Use the FSM from PS/2 packet parser and add a datapath to capture the incoming bytes.

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter BYTE1 = 0, BYTE2 = 1, BYTE3 = 2, DONE = 3;
    reg [2:0] state, next_state;
    reg [23:0] out_bytes_t;
        
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            BYTE1: begin 
                if (in[3] == 1) begin
                    next_state = BYTE2;
                end
                else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[3] == 0) begin
                    next_state = BYTE1;
                end
                else begin
                    next_state = BYTE2;
                end
            end
            default: next_state = BYTE1;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= BYTE1;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign done = (state == DONE) ? 1 : 0;

    // New: Datapath to store incoming bytes.
    assign out_bytes = done ? out_bytes_t : 24'b0;

    always @(posedge clk) begin
        if (reset) begin
            out_bytes_t <= 24'b0;
        end
        else begin
            if (state == BYTE1 || state == DONE) begin
                out_bytes_t[23:16] <= in[7:0];
            end
            else if (state == BYTE2) begin
                out_bytes_t[15:8] <= in[7:0];
            end
            else if (state == BYTE3) begin
                out_bytes_t[7:0] <= in[7:0];
            end
        end
    end

endmodule