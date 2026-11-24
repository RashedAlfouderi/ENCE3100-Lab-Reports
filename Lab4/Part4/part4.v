module part4 (
    input CLOCK_50,
    output [6:0] HEX0
);

reg [25:0] count;
reg [3:0] digit;

always @(posedge CLOCK_50)
begin
    if (count == 26'd49999999)
    begin
        count <= 0;

        if (digit == 9)
            digit <= 0;
        else
            digit <= digit + 1;
    end
    else
        count <= count + 1;
end

reg [6:0] display;

always @(*)
begin
    case (digit)
        4'd0: display = 7'b1000000;
        4'd1: display = 7'b1111001;
        4'd2: display = 7'b0100100;
        4'd3: display = 7'b0110000;
        4'd4: display = 7'b0011001;
        4'd5: display = 7'b0010010;
        4'd6: display = 7'b0000010;
        4'd7: display = 7'b1111000;
        4'd8: display = 7'b0000000;
        4'd9: display = 7'b0010000;
        default: display = 7'b1111111;
    endcase
end

assign HEX0 = display;

endmodule
