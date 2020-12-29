//See also: Lemmings1, Lemmings2, and Lemmings3.

//Although Lemmings can walk, fall, and dig, Lemmings aren't invulnerable. 
//If a Lemming falls for too long then hits the ground, it can splatter.
// In particular, if a Lemming falls for more than 20 clock cycles then hits the ground, 
//it will splatter and cease walking, falling, or digging (all 4 outputs become 0), forever (Or until the FSM gets reset).
//There is no upper limit on how far a Lemming can fall before hitting the ground. Lemmings only splatter when hitting the ground; 
//they do not splatter in mid-air.

//Extend your finite state machine to model this behaviour.

//Falling for 20 cycles is survivable:

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT   =0,
              FALL_L =1,
              DIG_L  =2,
              RIGHT  =3,
              DIG_R  =4,
              FALL_R =5,
              SPLAT  =6,
              HIT_GROUND_CYCLES = 20;

    reg [2:0] state, next_state;
    reg [7:0] fall_cycle_cout;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_cycle_cout <= 0;
        end
        else begin
            state <= next_state;

            if (aaah)
                fall_cycle_cout <= fall_cycle_cout + 1;
            else
                fall_cycle_cout <= 0;
        end
    end

    always @(*) begin
        case (state)
            LEFT: begin
                if (ground) begin
                    if (dig) begin
                        next_state = DIG_L;
                    end
                    else begin
                        if (bump_left)
                            next_state = RIGHT;
                        else
                            next_state = LEFT;
                    end
                end
                else begin
                    next_state = FALL_L;
                end
            end
            DIG_R: begin
                if (!ground) begin
                    next_state = FALL_R;
                end
                else begin
                    next_state = DIG_R;
                end
            end
            FALL_L: begin
                if (ground) begin 
                    if (fall_cycle_cout >= HIT_GROUND_CYCLES)
                        next_state = SPLAT;
                    else
                        next_state = LEFT;
                end
                else begin
                    next_state = FALL_L;
                end
            end
            RIGHT: begin
                if (ground) begin 
                    if (dig) begin
                        next_state = DIG_R;
                    end
                    else begin
                        if (bump_right)
                            next_state = LEFT;
                        else
                            next_state = RIGHT;
                    end
                end
                else begin
                    next_state = FALL_R;
                end
            end
            DIG_L: begin
                if (!ground) begin
                    next_state = FALL_L;
                end
                else begin
                    next_state = DIG_L;
                end
            end
            FALL_R: begin
                if (ground) begin
                    if (fall_cycle_cout >= HIT_GROUND_CYCLES)
                       next_state = SPLAT;
                    else
                       next_state = RIGHT;
                end
                else begin
                    next_state = FALL_R;
                end
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end
    
    assign walk_left = (state == LEFT) ? 1 : 0;
    assign walk_right = (state == RIGHT) ? 1 : 0;
    assign aaah = (state == FALL_R) | (state == FALL_L);
    assign digging = (state == DIG_R) | (state == DIG_L);

endmodule

