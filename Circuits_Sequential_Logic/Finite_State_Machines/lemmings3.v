//See also: Lemmings1 and Lemmings2.

//In addition to walking and falling, Lemmings can sometimes be told to do useful things, like dig (it starts digging when dig=1).
//A Lemming can dig if it is currently walking on ground (ground=1 and not falling), 
//and will continue digging until it reaches the other side (ground=0). At that point, since there is no ground, 
//it will fall (aaah!), then continue walking in its original direction once it hits ground again. 
//As with falling, being bumped while digging has no effect, and being told to dig when falling or when there is no ground is ignored.

//(In other words, a walking Lemming can fall, dig, or switch directions. 
//If more than one of these conditions are satisfied, fall has higher precedence than dig, 
//which has higher precedence than switching directions.)

//Extend your finite state machine to model this behaviour.

//See also: Lemmings4.

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
              FALL_R =5;
    
    reg [2:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
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
                    next_state = RIGHT;
                end
                else begin
                    next_state = FALL_R;
                end
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
