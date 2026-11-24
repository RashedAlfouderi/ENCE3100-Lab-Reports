module part5(input [9:0] SW, input [1:0] KEY,
             output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    reg [9:0] A;

    always @(negedge KEY[1] or negedge KEY[0]) begin
        if (!KEY[0]) A <= 10'b0;
        else A <= SW;
    end

    hex_decoder d0(SW[3:0], HEX0);
    hex_decoder d1(SW[7:4], HEX1);
    hex_decoder d2({2'b00, SW[9:8]}, HEX2);

    hex_decoder d3(A[3:0], HEX3);
    hex_decoder d4(A[7:4], HEX4);
    hex_decoder d5({2'b00, A[9:8]}, HEX5);

endmodule

module hex_decoder(input [3:0] n, output reg [7:0] seg);

    always @(*) begin
        case (n)
            4'h0: seg = 8'hC0;
            4'h1: seg = 8'hF9;
            4'h2: seg = 8'hA4;
            4'h3: seg = 8'hB0;
            4'h4: seg = 8'h99;
            4'h5: seg = 8'h92;
            4'h6: seg = 8'h82;
            4'h7: seg = 8'hF8;
            4'h8: seg = 8'h80;
            4'h9: seg = 8'h90;
            4'hA: seg = 8'h88;
            4'hB: seg = 8'h83;
            4'hC: seg = 8'hC6;
            4'hD: seg = 8'hA1;
            4'hE: seg = 8'h86;
            4'hF: seg = 8'h8E;
            default: seg = 8'hFF;
        endcase
    end

endmodule
