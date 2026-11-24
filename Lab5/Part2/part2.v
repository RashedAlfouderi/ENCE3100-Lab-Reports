module part2(input [9:0] SW, input [1:0] KEY, input CLOCK_50, output [9:0] LEDR);

    reg [7:0] S = 0;
    reg overflow = 0;
    reg [18:0] count = 0;
    reg pressed = 0;
    reg key_sync1 = 1, key_sync2 = 1;
    wire [8:0] result;

    assign result = SW[8] ? {1'b0, S} - {1'b0, SW[7:0]} : {1'b0, S} + {1'b0, SW[7:0]};

    always @(posedge CLOCK_50 or negedge KEY[0]) begin
        if (!KEY[0]) begin
            S <= 0;
            overflow <= 0;
            count <= 0;
            pressed <= 0;
            key_sync1 <= 1;
            key_sync2 <= 1;
        end
        else begin
            key_sync1 <= KEY[1];
            key_sync2 <= key_sync1;

            if (key_sync2 == pressed) count <= 0;
            else if (count == 19'd499999) begin
                count <= 0;
                pressed <= key_sync2;
                if (!key_sync2) begin
                    S <= result[7:0];
                    overflow <= result[8];
                end
            end
            else count <= count + 1'b1;
        end
    end

    assign LEDR = {1'b0, overflow, S};

endmodule
