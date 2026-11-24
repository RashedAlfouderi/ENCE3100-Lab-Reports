module my_TFF (
    input Clock,
    input Clear,
    input T,
    output reg Q
);

always @(posedge Clock)
begin
    if (!Clear)
        Q <= 1'b0;
    else if (T)
        Q <= ~Q;
end

endmodule
