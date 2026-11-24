`default_nettype none
module InstructionReg #(parameter N = 4)(
    input MainClock, input ClearInstr, input LatchInstr, input EnableInstr,
    input [N-1:0] Data, Instr,
    output reg [N-1:0] ToInstr, output [N-1:0] IB_BUS
);
    reg [N-1:0] saved_data;
    always @(posedge MainClock) begin
        if (ClearInstr) begin
            saved_data <= {N{1'b0}};
            ToInstr <= {N{1'b0}};
        end
        else if (LatchInstr) begin
            saved_data <= Data;
            ToInstr <= Instr;
        end
    end
    assign IB_BUS = EnableInstr ? saved_data : {N{1'bz}};
endmodule
`default_nettype wire
