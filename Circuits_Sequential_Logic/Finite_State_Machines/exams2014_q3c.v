//Given the state-assigned table shown below, implement the logic functions Y[0] and z.

//Present state
//y[2:0]    Next state Y[2:0] Output z
//          x=0    x=1
//  000     000    001        0
//  001     001    100        0
//  010     010    001        0
//  011     001    010        1
//  100     011    100        1

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state, next_state;
    reg z_tmp;
    reg Y0_tmp;
    
    assign state = y;
 
    always @(*) begin
        case ({state,x})
            {S0,1'b0}: next_state = S0;
            {S0,1'b1}: next_state = S1;
            {S1,1'b0}: next_state = S1;
            {S1,1'b1}: next_state = S4;
            {S2,1'b0}: next_state = S2;
            {S2,1'b1}: next_state = S1;
            {S3,1'b0}: next_state = S1;
            {S3,1'b1}: next_state = S2;
            {S4,1'b0}: next_state = S3;
            {S4,1'b1}: next_state = S4;
            default: next_state = S0;
        endcase
    end

    assign z = z_tmp;
    assign Y0 = next_state[0];

    always @(*) begin
        if (state == S3 || state == S4) begin
            z_tmp = 1;
        end
        else begin
            z_tmp = 0;
        end
    end

endmodule
