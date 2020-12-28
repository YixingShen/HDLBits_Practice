//Taken from 2015 midterm question 4

//Circuit B can be described by the following simulation waveform:

//row x   y   z
//1   0   0   1
//2   1   0   0
//3   0   1   0
//4   1   1   1

module top_module ( input x, input y, output z );

    assign z = (~x & ~y) | //row1
               (x & y); //row4

endmodule
