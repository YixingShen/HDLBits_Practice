//This is the second component in a series of five exercises that builds a complex counter out of several smaller circuits.
//See the final exercise for the overall design.

//Build a finite-state machine that searches for the sequence 1101 in an input bit stream. 
//When the sequence is found, it should set start_shifting to 1, forever, until reset. 
//Getting stuck in the final state is intended to model going to other states in a bigger FSM that is not yet implemented.
//We will be extending this FSM in the next few exercises.

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter S1 = 0, S2 = 1;
    parameter Sequence = 4'b1101;
    
    reg state, next_state;
    reg [3:0] bitstream;
    
    always @(*) begin
        case (state)
            S1: begin
                if (bitstream == Sequence)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                next_state = S2;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= S1;
        end
        else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            bitstream <= 4'b0000;
        end
        else begin
            bitstream <= {bitstream[2:0],data};
        end
    end
    
    assign start_shifting = (next_state == S2) ? 1 : 0;

endmodule