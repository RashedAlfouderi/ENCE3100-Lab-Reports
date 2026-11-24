module part3 (
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR
);

reg [2:0] U, V, W, X, Y;

always @(negedge KEY[0]) begin
    case (SW[9:7])
        3'd0: U <= SW[2:0];
        3'd1: V <= SW[2:0];
        3'd2: W <= SW[2:0];
        3'd3: X <= SW[2:0];
        3'd4: Y <= SW[2:0];
        default: ;
    endcase
end

wire [2:0] m0, m1, m2, M;

assign m0 = SW[3] ? V : U;
assign m1 = SW[3] ? X : W;
assign m2 = SW[4] ? m1 : m0;
assign M = SW[5] ? Y : m2;

assign LEDR = {7'b0, M};

endmodule
