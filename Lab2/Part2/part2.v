
module part2(input [3:0] SW, output [7:0] HEX0, HEX1);

    wire z;
    wire [3:0] M, corrected;
    wire [6:0] seg0, seg1;

    assign z = SW[3] & (SW[2] | SW[1]);
    assign corrected = {1'b0, ~(SW[2] ^ SW[1]), ~SW[1], SW[0]};
    assign M = ({4{~z}} & SW) | ({4{z}} & corrected);

    bcd_decoder d0(M, seg0);
    bcd_decoder d1({3'b000, z}, seg1);

    assign HEX0 = {1'b1, seg0};
    assign HEX1 = {1'b1, seg1};

endmodule

module bcd_decoder(input [3:0] b, output [6:0] seg);

    assign seg[0] = ~(b[1] | b[3] | (b[0] & b[2]) | (~b[0] & ~b[2]));
    assign seg[1] = ~(~b[2] | (b[0] & b[1]) | (~b[0] & ~b[1]));
    assign seg[2] = ~(b[0] | b[2] | ~b[1]);
    assign seg[3] = ~(b[3] | (b[1] & ~b[0]) | (b[1] & ~b[2]) | (~b[0] & ~b[2]) | (b[0] & b[2] & ~b[1]));
    assign seg[4] = ~((b[1] & ~b[0]) | (~b[0] & ~b[2]));
    assign seg[5] = ~(b[3] | (b[2] & ~b[0]) | (b[2] & ~b[1]) | (~b[0] & ~b[1]));
    assign seg[6] = ~(b[3] | (b[1] & ~b[0]) | (b[1] & ~b[2]) | (b[2] & ~b[1]));

endmodule
