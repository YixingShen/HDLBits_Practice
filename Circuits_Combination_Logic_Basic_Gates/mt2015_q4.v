//Taken from 2015 midterm question 4

//See mt2015_q4a and mt2015_q4b for the submodules used here. The top-level design consists of two instantiations each of subcircuits A and B, as shown below.


module top_module (input x, input y, output z);

    wire q4b_z, q4a_z;
    
    assign q4b_z = (~x & ~y) | (x & y);
    assign q4a_z = (x ^ y) & x;
    
    assign z = (q4a_z | q4b_z) ^ (q4a_z & q4b_z);
    
endmodule


               