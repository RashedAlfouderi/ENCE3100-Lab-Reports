
module part6(
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR,
    output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    reg [7:0] A, B;
    reg [4:0] t0, t1;
    reg [3:0] s0, s1;
    reg hundreds;
    wire invalid;

    always @(negedge KEY[0]) A <= SW[7:0];
    always @(negedge KEY[1]) B <= SW[7:0];

    always @(*) begin
        t0 = {1'b0, A[3:0]} + {1'b0, B[3:0]};
        if (t0 > 9) begin
            s0 = t0[3:0] + 4'd6;
            t1 = A[7:4] + B[7:4] + 1;
        end
        else begin
            s0 = t0[3:0];
            t1 = A[7:4] + B[7:4];
        end

        if (t1 > 9) begin
            s1 = t1[3:0] + 4'd6;
            hundreds = 1;
        end
        else begin
            s1 = t1[3:0];
            hundreds = 0;
        end
    end

    assign invalid = (A[3:0] > 9) || (A[7:4] > 9) ||
                     (B[3:0] > 9) || (B[7:4] > 9);

    assign LEDR = {hundreds, invalid, SW[7:0]};

    bcd_decoder d0(s0, HEX0);
    bcd_decoder d1(s1, HEX1);
    bcd_decoder d2(B[3:0], HEX2);
    bcd_decoder d3(B[7:4], HEX3);
    bcd_decoder d4(A[3:0], HEX4);
    bcd_decoder d5(A[7:4], HEX5);

endmodule

module bcd_decoder(input [3:0] b, output reg [7:0] seg);

    always @(*) begin
        case (b)
            4'd0: seg = 8'b11000000;
            4'd1: seg = 8'b11111001;
            4'd2: seg = 8'b10100100;
            4'd3: seg = 8'b10110000;
            4'd4: seg = 8'b10011001;
            4'd5: seg = 8'b10010010;
            4'd6: seg = 8'b10000010;
            4'd7: seg = 8'b11111000;
            4'd8: seg = 8'b10000000;
            4'd9: seg = 8'b10010000;
            default: seg = 8'b11111111;
        endcase
    end

endmodule
