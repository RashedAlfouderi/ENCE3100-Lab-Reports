
module part3(input [9:0] SW, output [9:0] LEDR);

    wire [3:0] S;
    wire c1, c2, c3, cout;

    full_adder fa0(SW[4], SW[0], SW[8], S[0], c1);
    full_adder fa1(SW[5], SW[1], c1, S[1], c2);
    full_adder fa2(SW[6], SW[2], c2, S[2], c3);
    full_adder fa3(SW[7], SW[3], c3, S[3], cout);

    assign LEDR = {SW[8:4], cout, S};

endmodule

module full_adder(input a, b, cin, output s, cout);

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
