module part6(input [2:0] SW, output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    display_digit d0(3'd0 - SW, HEX0);
    display_digit d1(3'd1 - SW, HEX1);
    display_digit d2(3'd2 - SW, HEX2);
    display_digit d3(3'd3 - SW, HEX3);
    display_digit d4(3'd4 - SW, HEX4);
    display_digit d5(3'd5 - SW, HEX5);

endmodule

module display_digit(input [2:0] pos, output reg [7:0] seg);

    always @(*) begin
        case (pos)
            3'd0: seg = 8'hC0;
            3'd1: seg = 8'hC7;
            3'd2: seg = 8'hC7;
            3'd3: seg = 8'h86;
            3'd4: seg = 8'h89;
            default: seg = 8'hFF;
        endcase
    end

endmodule
