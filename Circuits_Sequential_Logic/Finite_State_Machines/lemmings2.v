//See also: Lemmings1.

//In addition to walking left and right, Lemmings will fall (and presumably go "aaah!") if the ground disappears underneath them.

//In addition to walking left and right and changing direction when bumped, when ground=0, 
//the Lemming will fall and say "aaah!". When the ground reappears (ground=1), 
//the Lemming will resume walking in the same direction as before the fall. 
//Being bumped while falling does not affect the walking direction,
//and being bumped in the same cycle as ground disappears (but not yet falling),
//or when the ground reappears while still falling, also does not affect the walking direction.

//Build a finite state machine that models this behaviour.

//See also: Lemmings3 and Lemmings4.

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT=0, FALL_L=1, RIGHT=2, FALL_R=3;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        if (state == LEFT) begin
            if (ground) begin 
                if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            else begin
                next_state = FALL_L;
            end
        end
        else if (state == FALL_L) begin
            if (ground)
                next_state = LEFT;
            else
                next_state = FALL_L;
        end
        else if (state == FALL_R) begin
            if (ground)
                next_state = RIGHT;
            else
                next_state = FALL_R;
        end
        else if (state == RIGHT) begin
            if (ground) begin 
                if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            else begin
                next_state = FALL_R;
            end
        end
        else begin
            next_state = LEFT;
        end
    end

    assign walk_left = (state == LEFT) ? 1 : 0;
    assign walk_right = (state == RIGHT) ? 1 : 0;
    assign aaah = (state == FALL_R) | (state == FALL_L);

endmodule
