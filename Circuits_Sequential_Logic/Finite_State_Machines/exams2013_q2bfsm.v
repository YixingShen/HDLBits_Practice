//Consider a finite state machine that is used to control some type of motor. 
//The FSM has inputs x and y, which come from the motor, and produces outputs f and g, which control the motor. 
//There is also a clock input called clk and a reset input called resetn.

//The FSM has to work as follows. As long as the reset input is asserted, the FSM stays in a beginning state, called state A.
//When the reset signal is de-asserted, then after the next clock edge the FSM has to set the output f to 1 for one clock cycle. 
//Then, the FSM has to monitor the x input. When x has produced the values 1, 0, 1 in three successive clock cycles, 
//then g should be set to 1 on the following clock cycle. 
//While maintaining g = 1 the FSM has to monitor the y input.
//If y has the value 1 within at most two clock cycles, then the FSM should maintain g = 1 permanently (that is, until reset).
//But if y does not become 1 within two clock cycles, then the FSM should set g = 0 permanently (until reset).

//(The original exam question asked for a state diagram only. But here, implement the FSM.)

//Hint...
//The FSM does not begin to monitor the x input until the cycle after f is 1.

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter NONE = 0, A = 1, B0 = 2, B1 = 3, B2 = 4, C1 = 5, C2 = 6, D1 = 7, D2 = 8;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            NONE: begin
                next_state = A;
            end
            A: begin
                next_state = B0;
            end
            B0: begin
                next_state = x ? B1: B0;
            end
            B1: begin //x = 0b1
                next_state = x ? B1: B2;
            end
            B2: begin //x = 0b10
                next_state = x ? C1: B0;
            end
            C1: begin //x = 0b101
                next_state = y ? D1 : C2;
            end
            C2: begin //y = 0b0
                next_state = y ? D1 : D2;
            end
            D1: begin //y = 0b1 or 0b01
                next_state = D1;
            end
            D2: begin //y = 0b00
                next_state = D2;
            end
        endcase
    end

    always @(posedge clk) begin
        if (resetn == 0) begin
            state <= NONE;
        end
        else begin
            state <= next_state;
        end
    end

    assign f = (state == A) ? 1 : 0;
    assign g = (state == C1 || state == C2 || state == D1) ? 1 : 0;

endmodule
