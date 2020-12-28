module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    assign out = (~c & ~d & ~a & ~b) | //out = 1, cd 00, ab 00
                 (~c & ~d & ~a &  b) | //out = 1, cd 00, ab 01
                 //(~c & ~d &  a &  b) | //out = 0, cd 00, ab 11
                 (~c & ~d &  a & ~b) | //out = 1, cd 00, ab 10
                 (~c &  d & ~a & ~b) | //out = 1, cd 01, ab 00
                 //(~c &  d & ~a &  b) | //out = 0, cd 01, ab 01
                 //(~c &  d &  a &  b) | //out = 0, cd 01, ab 11
                 (~c &  d &  a & ~b) | //out = 1, cd 01, ab 10
                 //( c &  d & ~a & ~b) | //out = 0, cd 11, ab 00
                 ( c &  d & ~a &  b) | //out = 1, cd 11, ab 01
                 ( c &  d &  a &  b) | //out = 1, cd 11, ab 11
                 ( c &  d &  a & ~b) | //out = 1, cd 11, ab 10
                 ( c & ~d & ~a & ~b) | //out = 1, cd 10, ab 00
                 ( c & ~d & ~a &  b);// | //out = 1, cd 10, ab 01
                 //( c & ~d & ~a & ~b) | //out = 0, cd 10, ab 11
                 //( c & ~d &  a & ~b) | //out = 0, cd 10, ab 10

endmodule