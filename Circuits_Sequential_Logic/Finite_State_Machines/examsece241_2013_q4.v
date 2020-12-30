//Also include an active-high synchronous reset that resets the state machine to a state equivalent 
//to if the water level had been low for a long time (no sensors asserted, and all four outputs asserted).

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter LevelA = 0, LevelB = 1, LevelC = 2, LevelD = 3;
    
    reg [2:0] state, next_state;
    reg dfr_tmp;
    wire [2:0] fr;

    assign dfr = dfr_tmp;
    assign {fr3,fr2,fr1} = fr;

    always @(*) begin
        if (s[3] == 1 && s[2] == 1 && s[1] == 1) begin
            next_state = LevelD;
        end
        else if (s[2] == 1 && s[1] == 1) begin
            next_state = LevelC;
        end
        else if (s[1] == 1) begin
            next_state = LevelB;
        end
        else begin
            next_state = LevelA;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            dfr_tmp <= 1;
        end
        else begin
            state <= next_state;

            if (next_state < state)
                dfr_tmp <= 1;
            else if (next_state > state)
                dfr_tmp <= 0;
        end
    end
    
    always @(*) begin
        case (state)
            LevelA: fr = 3'b111;
            LevelB: fr = 3'b011;
            LevelC: fr = 3'b001;
            LevelD: fr = 3'b000;
            default: fr = 3'b111;
        endcase
    end
       
endmodule
