//Consider the state machine shown below, which has one input w and one output z.

//For this part, assume that a one-hot code is used with the state assignment
//'y[6:1] = 000001, 000010, 000100, 001000, 010000, 100000 for states A, B,..., F, respectively.

//Write a logic expression for the next-state signals Y2 and Y4. 
//(Derive the logic equations by inspection assuming a one-hot encoding. 
//The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).

module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    parameter OneHotBitA = 1,
              OneHotBitB = 2,
              OneHotBitC = 3,
              OneHotBitD = 4,
              OneHotBitE = 5,
              OneHotBitF = 6;
    
    reg [6:1] state, next_state;
    
    assign state = y;
    assign Y2 = next_state[2];
    assign Y4 = next_state[4];
    
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
    
endmodule
