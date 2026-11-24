module part2(input [9:0] SW, input [1:0] KEY, output [9:0] LEDR);

reg [7:0] X, Y;
wire [7:0] M;

always @(negedge KEY[0]) X <= SW[7:0];
always @(negedge KEY[1]) Y <= SW[7:0];

assign M = SW[9] ? Y : X;
assign LEDR = {SW[9], 1'b0, M};

endmodule
