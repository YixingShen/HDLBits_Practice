//Consider the state machine shown below, which has one input w and one output z.

//Implement the state machine. (This part wasn't on the midterm, but coding up FSMs is good practice).

module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    parameter OneHotBitA = 1,
              OneHotBitB = 2,
              OneHotBitC = 3,
              OneHotBitD = 4,
              OneHotBitE = 5,
              OneHotBitF = 6;

    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    reg [6:1] state, next_state;

    always @(*) begin
        if (state[OneHotBitA])
            next_state = w ? A : B;
        else if (state[OneHotBitB])
            next_state = w ? D : C;
        else if (state[OneHotBitC])
            next_state = w ? D : E;
        else if (state[OneHotBitD])
            next_state = w ? A : F;
        else if (state[OneHotBitE])
            next_state = w ? D : E;
        else if (state[OneHotBitF])
            next_state = w ? D : C;
        else
            next_state = A;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign z = (state[OneHotBitE] | state[OneHotBitF]) ? 1 : 0;
    
endmodule
