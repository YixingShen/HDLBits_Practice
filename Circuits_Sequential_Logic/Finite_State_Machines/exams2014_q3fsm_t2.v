//Consider a finite state machine with inputs s and w. Assume that the FSM begins in a reset state called A, as depicted below.
//The FSM remains in state A as long as s = 0, and it moves to state B when s = 1. 
//Once in state B the FSM examines the value of the input w in the next three clock cycles. 
//If w = 1 in exactly two of these clock cycles, then the FSM has to set an output z to 1 in the following clock cycle. 
//Otherwise z has to be 0. The FSM continues checking w for the next three clock cycles, and so on.
//The timing diagram below illustrates the required values of z for different values of w.

//Use as few states as possible. Note that the s input is used only in state A, so you need to consider just the w input.

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 0, B = 1;
    reg [1:0] state, next_state;
    reg [2:0] din;
    reg [1:0] cycle_count;

    always @(*)begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    assign z = (cycle_count == 1) && (din == 3'b011 || din == 3'b101 || din == 3'b110);

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 0;
            din <= 0;
        end
        else if (next_state == B) begin
            din <= {din[1:0],w};

            if (cycle_count == 3) begin
                cycle_count <= 1;
            end
            else begin
                cycle_count <= cycle_count + 1;
            end
        end
    end

endmodule
