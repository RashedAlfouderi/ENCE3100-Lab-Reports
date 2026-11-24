module part5(
    input [9:0] SW,
    input [1:0] KEY,
    input CLOCK_50,
    output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    reg [7:0] A = 0, B = 0;
    reg [15:0] P = 0;
    reg [18:0] count = 0;
    reg pressed = 0;
    reg key_sync1 = 1, key_sync2 = 1;

    wire [15:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
    wire [15:0] s0, s1, s2, s3, t0, t1, product;
    wire [7:0] shown;

    assign pp0 = B[0] ? ({8'b0, A} << 0) : 16'b0;
    assign pp1 = B[1] ? ({8'b0, A} << 1) : 16'b0;
    assign pp2 = B[2] ? ({8'b0, A} << 2) : 16'b0;
    assign pp3 = B[3] ? ({8'b0, A} << 3) : 16'b0;
    assign pp4 = B[4] ? ({8'b0, A} << 4) : 16'b0;
    assign pp5 = B[5] ? ({8'b0, A} << 5) : 16'b0;
    assign pp6 = B[6] ? ({8'b0, A} << 6) : 16'b0;
    assign pp7 = B[7] ? ({8'b0, A} << 7) : 16'b0;

    assign s0 = pp0 + pp1;
    assign s1 = pp2 + pp3;
    assign s2 = pp4 + pp5;
    assign s3 = pp6 + pp7;

    assign t0 = s0 + s1;
    assign t1 = s2 + s3;

    assign product = t0 + t1;

    always @(posedge CLOCK_50 or negedge KEY[0]) begin
        if (!KEY[0]) begin
            A <= 0;
            B <= 0;
            P <= 0;
            count <= 0;
            pressed <= 0;
            key_sync1 <= 1;
            key_sync2 <= 1;
        end
        else begin
            key_sync1 <= KEY[1];
            key_sync2 <= key_sync1;

            P <= product;

            if (key_sync2 == pressed) count <= 0;
            else if (count == 19'd499999) begin
                count <= 0;
                pressed <= key_sync2;

                if (!key_sync2) begin
                    if (!SW[8]) A <= SW[7:0];
                    else B <= SW[7:0];
                end
            end
            else count <= count + 1'b1;
        end
    end

    assign shown = SW[9] ? B : A;

    hex_decoder5 h0(P[3:0], HEX0);
    hex_decoder5 h1(P[7:4], HEX1);
    hex_decoder5 h2(P[11:8], HEX2);
    hex_decoder5 h3(P[15:12], HEX3);
    hex_decoder5 h4(shown[3:0], HEX4);
    hex_decoder5 h5(shown[7:4], HEX5);

endmodule

module hex_decoder5(input [3:0] n, output reg [7:0] seg);

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
