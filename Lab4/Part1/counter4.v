module counter4 (
    input Clock,
    input Enable,
    input Clear,
    output [3:0] Q
);

wire [3:0] T;

assign T[0] = Enable;
assign T[1] = Enable & Q[0];
assign T[2] = Enable & Q[0] & Q[1];
assign T[3] = Enable & Q[0] & Q[1] & Q[2];

my_TFF FF0 (Clock, Clear, T[0], Q[0]);
my_TFF FF1 (Clock, Clear, T[1], Q[1]);
my_TFF FF2 (Clock, Clear, T[2], Q[2]);
my_TFF FF3 (Clock, Clear, T[3], Q[3]);

endmodule
