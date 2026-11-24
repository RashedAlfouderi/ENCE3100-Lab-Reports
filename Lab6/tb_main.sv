`timescale 1ns/1ps
module tb_main;
    reg clk = 0;
    reg [9:0] SW = 10'b1000110101;
    reg [1:0] KEY = 2'b11;
    wire [9:0] LEDR;
    wire [7:0] HEX0;
    wire uart_tx;
    integer cycles;
    reg found = 0;
    always #10 clk = ~clk;
    main #(.HOLD_TICKS(20000), .DEBOUNCE_CYCLES(20)) dut(
        .MAX10_CLK1_50(clk), .SW(SW), .KEY(KEY), .UART_RX(1'b1),
        .UART_TX(uart_tx), .LEDR(LEDR), .HEX0(HEX0)
    );
    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0,tb_main);
        KEY[0] = 0;
        repeat (10) @(posedge clk);
        @(negedge clk); KEY[0] = 1;
        repeat (10) @(posedge clk);
        @(negedge clk); KEY[1] = 0;
        repeat (40) @(posedge clk);
        @(negedge clk); KEY[1] = 1;
        for (cycles=0; cycles<35000; cycles=cycles+1) begin
            @(posedge clk); #1;
            if (LEDR[8] && LEDR[7:0] === 8'h35 && HEX0 === 8'b00010010) begin
                found = 1;
            end
        end
        if (found) $display("PASS: UART received ASCII 5, LEDR=35, HEX0 displays 5");
        else $display("FAIL: UART reception and display check");
        if (LEDR[8] === 1'b0 && HEX0 === 8'hff)
            $display("PASS: 5-second display timer expired (shortened for simulation)");
        else $display("FAIL: display did not clear after HOLD_TICKS");
        $finish;
    end
endmodule
