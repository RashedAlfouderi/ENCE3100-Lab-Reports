
module part5(input [9:0] SW, input [1:0] KEY,
             output [9:0] LEDR,
             output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    reg [7:0] A, B;
    wire [3:0] ones, tens;
    wire c1, c2, invalid;

    always @(negedge KEY[0])
        A <= SW[7:0];

    always @(negedge KEY[1])
        B <= SW[7:0];

    bcd_add add0(A[3:0], B[3:0], 1'b0, ones, c1);
    bcd_add add1(A[7:4], B[7:4], c1, tens, c2);

    assign invalid = (A[3:0] > 9) | (A[7:4] > 9) |
                     (B[3:0] > 9) | (B[7:4] > 9);

    assign LEDR = {invalid, 8'b00000000, c2};

    bcd_decoder d0(ones, HEX0);
    bcd_decoder d1(tens, HEX1);
    bcd_decoder d2(B[3:0], HEX2);
    bcd_decoder d3(B[7:4], HEX3);
    bcd_decoder d4(A[3:0], HEX4);
    bcd_decoder d5(A[7:4], HEX5);

endmodule

module bcd_add(input [3:0] a, b, input cin,
               output [3:0] s, output cout);

    wire [4:0] sum;
    wire [4:0] corrected;

    assign sum = {1'b0, a} + {1'b0, b} + cin;
    assign cout = (sum > 5'd9);
    assign corrected = cout ? sum + 5'd6 : sum;
    assign s = corrected[3:0];

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
