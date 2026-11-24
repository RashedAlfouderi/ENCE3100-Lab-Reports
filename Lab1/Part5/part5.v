module part5(input [2:0] SW, output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4);

    wire [2:0] c0, c1, c2, c3, c4;

    mux5 m4(SW, 3'd0, 3'd1, 3'd2, 3'd2, 3'd3, c4);
    mux5 m3(SW, 3'd1, 3'd2, 3'd2, 3'd3, 3'd0, c3);
    mux5 m2(SW, 3'd2, 3'd2, 3'd3, 3'd0, 3'd1, c2);
    mux5 m1(SW, 3'd2, 3'd3, 3'd0, 3'd1, 3'd2, c1);
    mux5 m0(SW, 3'd3, 3'd0, 3'd1, 3'd2, 3'd2, c0);

    decoder d4(c4, HEX4);
    decoder d3(c3, HEX3);
    decoder d2(c2, HEX2);
    decoder d1(c1, HEX1);
    decoder d0(c0, HEX0);

endmodule

module mux5(input [2:0] s, a, b, c, d, e, output reg [2:0] y);

    always @(*) begin
        case (s)
            3'd0: y = a;
            3'd1: y = b;
            3'd2: y = c;
            3'd3: y = d;
            3'd4: y = e;
            default: y = a;
        endcase
    end

endmodule

module decoder(input [2:0] c, output reg [7:0] seg);

    always @(*) begin
        case (c)
            3'd0: seg = 8'h89;
            3'd1: seg = 8'h86;
            3'd2: seg = 8'hC7;
            3'd3: seg = 8'hC0;
            default: seg = 8'hFF;
        endcase
    end

endmodule
