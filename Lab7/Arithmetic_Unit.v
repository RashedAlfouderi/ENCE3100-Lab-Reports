`default_nettype none
module Arithmetic_Unit #(parameter N = 4)(
    input EnableALU, input AddSub,
    input [N-1:0] A, B,
    output reg Carry, output reg [N-1:0] IB_ALU
);
    reg [N:0] result;
    always @(*) begin
        if (AddSub) result = {1'b0, A} - {1'b0, B};
        else result = {1'b0, A} + {1'b0, B};
        Carry = EnableALU ? result[N] : 1'b0;
        IB_ALU = EnableALU ? result[N-1:0] : {N{1'bz}};
    end
endmodule
`default_nettype wire
