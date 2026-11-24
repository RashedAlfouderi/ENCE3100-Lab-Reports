module part5 (
    input CLOCK_50,
    output reg [6:0] HEX0,
    output reg [6:0] HEX1,
    output reg [6:0] HEX2,
    output reg [6:0] HEX3,
    output reg [6:0] HEX4,
    output reg [6:0] HEX5
);

reg [25:0] count;
reg [3:0] position;

always @(posedge CLOCK_50)
begin
    if (count == 26'd49999999)
    begin
        count <= 0;

        if (position == 6)
            position <= 0;
        else
            position <= position + 1;
    end
    else
        count <= count + 1;
end

always @(*)
begin
    HEX0 = 7'b1111111;
    HEX1 = 7'b1111111;
    HEX2 = 7'b1111111;
    HEX3 = 7'b1111111;
    HEX4 = 7'b1111111;
    HEX5 = 7'b1111111;

    case (position)

        0:
        begin
            HEX4 = 7'b0001001;
            HEX3 = 7'b0000110;
            HEX2 = 7'b1000111;
            HEX1 = 7'b1000111;
            HEX0 = 7'b1000000;
        end

        1:
        begin
            HEX5 = 7'b0001001;
            HEX4 = 7'b0000110;
            HEX3 = 7'b1000111;
            HEX2 = 7'b1000111;
            HEX1 = 7'b1000000;
        end

        2:
        begin
            HEX5 = 7'b0000110;
            HEX4 = 7'b1000111;
            HEX3 = 7'b1000111;
            HEX2 = 7'b1000000;
            HEX0 = 7'b0001001;
        end

        3:
        begin
            HEX5 = 7'b1000111;
            HEX4 = 7'b1000111;
            HEX3 = 7'b1000000;
            HEX1 = 7'b0001001;
            HEX0 = 7'b0000110;
        end

        4:
        begin
            HEX5 = 7'b1000111;
            HEX4 = 7'b1000000;
            HEX2 = 7'b0001001;
            HEX1 = 7'b0000110;
            HEX0 = 7'b1000111;
        end

        5:
        begin
            HEX5 = 7'b1000000;
            HEX3 = 7'b0001001;
            HEX2 = 7'b0000110;
            HEX1 = 7'b1000111;
            HEX0 = 7'b1000111;
        end

        6:
        begin
            HEX4 = 7'b0001001;
            HEX3 = 7'b0000110;
            HEX2 = 7'b1000111;
            HEX1 = 7'b1000111;
            HEX0 = 7'b1000000;
        end

        default:
        begin
            HEX0 = 7'b1111111;
            HEX1 = 7'b1111111;
            HEX2 = 7'b1111111;
            HEX3 = 7'b1111111;
            HEX4 = 7'b1111111;
            HEX5 = 7'b1111111;
        end

    endcase
end

endmodule
