module counter8 (
    input Clock,
    input Enable,
    input Clear,
    output [7:0] Q
);

wire [7:0] T;

assign T[0] = Enable;
assign T[1] = Enable & Q[0];
assign T[2] = Enable & Q[0] & Q[1];
assign T[3] = Enable & Q[0] & Q[1] & Q[2];
assign T[4] = Enable & Q[0] & Q[1] & Q[2] & Q[3];
assign T[5] = Enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4];
assign T[6] = Enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5];
assign T[7] = Enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6];

my_TFF FF0 (Clock, Clear, T[0], Q[0]);
my_TFF FF1 (Clock, Clear, T[1], Q[1]);
my_TFF FF2 (Clock, Clear, T[2], Q[2]);
my_TFF FF3 (Clock, Clear, T[3], Q[3]);
my_TFF FF4 (Clock, Clear, T[4], Q[4]);
my_TFF FF5 (Clock, Clear, T[5], Q[5]);
my_TFF FF6 (Clock, Clear, T[6], Q[6]);
my_TFF FF7 (Clock, Clear, T[7], Q[7]);

endmodule
