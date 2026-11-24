module part3(input [9:0] SW, output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    wire [3:0] A, B;
    wire [7:0] p0, p1, p2, p3, P;

    assign A = SW[7:4];
    assign B = SW[3:0];

    assign p0 = B[0] ? {4'b0, A} : 8'b0;
    assign p1 = B[1] ? {3'b0, A, 1'b0} : 8'b0;
    assign p2 = B[2] ? {2'b0, A, 2'b0} : 8'b0;
    assign p3 = B[3] ? {1'b0, A, 3'b0} : 8'b0;

    assign P = p0 + p1 + p2 + p3;

    hex_decoder h0(P[3:0], HEX0);
    hex_decoder h1(P[7:4], HEX1);
    hex_decoder h4(B, HEX4);
    hex_decoder h5(A, HEX5);

    assign HEX2 = 8'hFF;
    assign HEX3 = 8'hFF;

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
        endcase
    end

endmodule
