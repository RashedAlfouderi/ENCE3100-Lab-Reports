module part3(input D, Clk, output Q);

    wire Qm;

    gated_d master(D, ~Clk, Qm);
    gated_d slave(Qm, Clk, Q);

endmodule

module gated_d(input D, Clk, output Q);

    wire R, S_g, R_g, Qa, Qb /* synthesis keep */;

    assign R = ~D;
    assign S_g = ~(D & Clk);
    assign R_g = ~(R & Clk);
    assign Qa = ~(S_g & Qb);
    assign Qb = ~(R_g & Qa);
    assign Q = Qa;

endmodule
