module part4(input [2:0] SW, output reg [7:0] HEX0);

    always @(*) begin
        case (SW)
            3'b000: HEX0 = 8'h89;
            3'b001: HEX0 = 8'h86;
            3'b010: HEX0 = 8'hC7;
            3'b011: HEX0 = 8'hC0;
            default: HEX0 = 8'hFF;
        endcase
    end

endmodule
