module counter16 (
    input Clock,
    input Enable,
    input Clear,
    output reg [15:0] Q
);

always @(posedge Clock)
begin
    if (!Clear)
        Q <= 16'b0;
    else if (Enable)
        Q <= Q + 1;
end

endmodule
