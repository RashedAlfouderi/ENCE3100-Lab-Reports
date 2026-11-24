module part1(
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR
);

    reg [7:0] S;
    reg overflow;
    wire [8:0] result;

    assign result = {1'b0, S} + {1'b0, SW[7:0]};

    always @(negedge KEY[1] or negedge KEY[0]) begin
        if (!KEY[0]) begin
            S <= 8'd0;
            overflow <= 1'b0;
        end
        else begin
            S <= result[7:0];
            overflow <= result[8];
        end
    end

    assign LEDR = {1'b0, overflow, S};

endmodule
