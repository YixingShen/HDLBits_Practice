//Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). 
//Your counters are clocked by a fast-running clk, with a pulse on ena whenever your clock should increment (i.e., once per second).

//reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal)
//digits each for hours (01-12), minutes (00-59), and seconds (00-59). Reset has higher priority than enable, and can occur even when not enabled.

//The following timing diagram shows the rollover behaviour from 11:59:59 AM to 12:00:00 PM and the synchronous reset and enable behaviour.

module BinToBCD(
    input [7:0] bin,
    output [7:0] dec); 
    
    assign dec[7:4] = bin / 10;
    assign dec[3:0] = bin % 10;
    
endmodule
    
module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    reg [7:0] hh_bin;
    reg [7:0] mm_bin;
    reg [7:0] ss_bin;
    
    BinToBCD inst1(hh_bin, hh);
    BinToBCD inst2(mm_bin, mm);
    BinToBCD inst3(ss_bin, ss);

    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
        end
        else begin
            if (hh_bin == 11 && mm_bin == 59 && ss_bin == 59) begin
                pm = ~pm;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            ss_bin <= 0;
        end
        else if (ena) begin
            if (ss_bin == 59) begin
                ss_bin <= 0;
            end
            else begin
                ss_bin <= ss_bin + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            mm_bin <= 0;
        end
        else if (ena) begin
            if (mm_bin == 59 && ss_bin == 59) begin
                mm_bin <= 0;
            end
            else if (ss_bin == 59) begin
                mm_bin <= mm_bin + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            hh_bin <= 12;
        end
        else if (ena) begin
            if (hh_bin == 12 && mm_bin == 59 && ss_bin == 59) begin
                hh_bin <= 1;
            end
            else if (mm_bin == 59 && ss_bin == 59) begin
                hh_bin <= hh_bin + 1;
            end
        end
    end

endmodule
