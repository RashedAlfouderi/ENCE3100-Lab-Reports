
module part7(
    input [9:0] SW,
    output [7:0] HEX0, HEX1
);

    wire [3:0] tens, ones;

    assign tens = SW[5:0] / 10;
    assign ones = SW[5:0] % 10;

    bcd_decoder d0(ones, HEX0);
    bcd_decoder d1(tens, HEX1);

endmodule

module bcd_decoder(input [3:0] b, output reg [7:0] seg);

    always @(*) begin
        case (b)
            0: seg = 8'b11000000;
            1: seg = 8'b11111001;
            2: seg = 8'b10100100;
            3: seg = 8'b10110000;
            4: seg = 8'b10011001;
            5: seg = 8'b10010010;
            6: seg = 8'b10000010;
            7: seg = 8'b11111000;
            8: seg = 8'b10000000;
            9: seg = 8'b10010000;
            default: seg = 8'b11111111;
        endcase
    end

endmodule
