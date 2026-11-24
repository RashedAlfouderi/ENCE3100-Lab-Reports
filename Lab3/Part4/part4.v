module part4(input D, Clk, output Qa, Qb, Qc);

    d_latch l1(D, Clk, Qa);
    d_ff_pos f1(D, Clk, Qb);
    d_ff_neg f2(D, Clk, Qc);

endmodule

module d_latch(input D, Clk, output reg Q);
    always @(*) begin
        if (Clk) Q = D;
    end
endmodule

module d_ff_pos(input D, Clk, output reg Q);
    always @(posedge Clk) Q <= D;
endmodule

module d_ff_neg(input D, Clk, output reg Q);
    always @(negedge Clk) Q <= D;
endmodule
