//Write complete Verilog code that represents this FSM. Use separate always blocks for the state table and the state flip-flops, as done in lectures.
//Describe the FSM output, which is called z, using either continuous assignment statement(s) or an always block (at your discretion).
//Assign any state codes that you wish to use.

module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A = 0,
              B = 1,
              C = 2,
              D = 3,
              E = 4,
              F = 5;

    reg [3:1] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = ((state == E) || (state == F)) ? 1 : 0;
    
endmodule