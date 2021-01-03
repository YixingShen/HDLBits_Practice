//Given the following state machine with 3 inputs, 3 outputs, and 10 states:

//Derive next-state logic equations and output logic equations by inspection assuming the following one-hot encoding is used: 
//(S, S1, S11, S110, B0, B1, B2, B3, Count, Wait) = (10'b0000000001, 10'b0000000010, 10'b0000000100, ... , 10'b1000000000)

//Derive state transition and output logic equations by inspection assuming a one-hot encoding. 
//Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. 
//(The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).

//Write code that generates the following equations:

//B3_next -- next-state logic for state B1
//S_next
//S1_next
//Count_next
//Wait_next
//done -- output logic
//counting
//shift_ena

//Hint...
//Logic equations for one-hot state transition logic can be derived by looking at in-edges of the state transition diagram.

module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

    // assign B3_next = ...;
    // assign S_next = ...;
    // etc.

endmodule