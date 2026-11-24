
module part4(input [9:0] SW, output [9:0] LEDR,
             output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    wire [3:0] A, B, S;
    wire c1, c2, c3, cout;
    wire [4:0] total;
    wire [3:0] ones;
    wire tens, invalid;

    assign A = SW[7:4];
    assign B = SW[3:0];

    full_adder fa0(A[0], B[0], SW[8], S[0], c1);
    full_adder fa1(A[1], B[1], c1, S[1], c2);
    full_adder fa2(A[2], B[2], c2, S[2], c3);
    full_adder fa3(A[3], B[3], c3, S[3], cout);

    assign total = {cout, S};
    assign tens = (total >= 5'd10);
    assign ones = tens ? total - 5'd10 : total;
    assign invalid = (A > 9) | (B > 9);

    assign LEDR = {invalid, 4'b0000, cout, S};

    bcd_decoder d0(ones, HEX0);
    bcd_decoder d1({3'b000, tens}, HEX1);
    bcd_decoder d2(B, HEX2);
    bcd_decoder d4(A, HEX4);

    assign HEX3 = 8'hFF;
    assign HEX5 = 8'hFF;

endmodule

module full_adder(input a, b, cin, output s, cout);

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module bcd_decoder(input [3:0] b, output [7:0] seg);

    assign seg = b == 0 ? 8'hC0 :
                 b == 1 ? 8'hF9 :
                 b == 2 ? 8'hA4 :
                 b == 3 ? 8'hB0 :
                 b == 4 ? 8'h99 :
                 b == 5 ? 8'h92 :
                 b == 6 ? 8'h82 :
                 b == 7 ? 8'hF8 :
                 b == 8 ? 8'h80 :
                 b == 9 ? 8'h90 : 8'hFF;

endmodule
