module part1(input [9:0] SW, output [7:0] HEX0, HEX1, HEX2, HEX3);

    wire [6:0] seg0, seg1, seg2;

    bcd_decoder d0(SW[3:0], seg0);
    bcd_decoder d1(SW[7:4], seg1);
    bcd_decoder d2({2'b00, SW[9:8]}, seg2);

    assign HEX0 = {1'b1, seg0};
    assign HEX1 = {1'b1, seg1};
    assign HEX2 = {1'b1, seg2};
    assign HEX3 = 8'hFF;

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
