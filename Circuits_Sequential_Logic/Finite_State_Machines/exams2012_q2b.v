//The state diagram for this question is shown again below.


//Assume that a one-hot code is used with the state assignment y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
//Write a logic expression for the signal Y1, which is the input of state flip-flop y[1].
//Write a logic expression for the signal Y3, which is the input of state flip-flop y[3].
//(Derive the logic equations by inspection assuming a one-hot encoding.
//The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).

//Hint...
//Logic equations for one-hot state transition logic can be derived by looking at in-edges of the state transition diagram.

module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    parameter OneHotBitA = 0,
              OneHotBitB = 1,
              OneHotBitC = 2,
              OneHotBitD = 3,
              OneHotBitE = 4,
              OneHotBitF = 5;

    parameter A = 1 << OneHotBitA,
              B = 1 << OneHotBitB,
              C = 1 << OneHotBitC,
              D = 1 << OneHotBitD,
              E = 1 << OneHotBitE,
              F = 1 << OneHotBitF;

    reg [5:0] state, next_state;

    assign Y1 = next_state[OneHotBitB];
    assign Y3 = next_state[OneHotBitD];
    assign state = y;
    
    always @(*) begin
        if (state[OneHotBitA]) begin
            next_state = w ? B : A;
        end
        else if (state[OneHotBitB]) begin
            next_state = w ? C : D;
        end
        else if (state[OneHotBitC]) begin
            next_state = w ? E : D;
        end
        else if (state[OneHotBitD]) begin
            next_state = w ? F : A;
        end
        else if (state[OneHotBitE]) begin
            next_state = w ? E : D;
        end
        else if (state[OneHotBitF]) begin
            next_state = w ? C : D;
        end
        else begin
            next_state = A;
        end
    end

endmodule
