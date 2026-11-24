module main #(
    parameter CLOCK_HZ = 50000000,
    parameter BAUD = 115200,
    parameter HOLD_TICKS = 250000000,
    parameter DEBOUNCE_CYCLES = 500000
)(
    input MAX10_CLK1_50,
    input [9:0] SW,
    input [1:0] KEY,
    input UART_RX,
    output UART_TX,
    output [9:0] LEDR,
    output [7:0] HEX0
);
    wire clk = MAX10_CLK1_50;
    wire reset = ~KEY[0];
    wire rx_line = SW[9] ? UART_TX : UART_RX;
    wire rx_ready, tx_busy;
    wire [7:0] rx_data;
    wire rx_idle, rx_end;
    wire tx_start;
    wire [7:0] tx_data;
    wire key_pulse;
    reg [7:0] last_char = 0;
    reg pending_echo = 0;
    reg pending_manual = 0;
    reg [7:0] manual_char = 0;
    reg [31:0] elapsed = 0;
    localparam S_IDLE = 1'b0, S_DISPLAY = 1'b1;
    reg state = S_IDLE;

    uart_button #(.DEBOUNCE_CYCLES(DEBOUNCE_CYCLES)) button1(.clk(clk), .reset(reset), .key_n(KEY[1]), .pulse(key_pulse));
    async_receiver #(.ClkFrequency(CLOCK_HZ), .Baud(BAUD)) receiver(
        .clk(clk), .RxD(rx_line), .RxD_data_ready(rx_ready),
        .RxD_data(rx_data), .RxD_idle(rx_idle), .RxD_endofpacket(rx_end)
    );
    assign tx_start = !tx_busy && (pending_echo || pending_manual);
    assign tx_data = pending_echo ? last_char : manual_char;
    async_transmitter #(.ClkFrequency(CLOCK_HZ), .Baud(BAUD)) transmitter(
        .clk(clk), .TxD_start(tx_start), .TxD_data(tx_data),
        .TxD(UART_TX), .TxD_busy(tx_busy)
    );

    always @(posedge clk) begin
        if (reset) begin
            last_char <= 0;
            pending_echo <= 0;
            pending_manual <= 0;
            manual_char <= 0;
            elapsed <= 0;
            state <= S_IDLE;
        end else begin
            if (tx_start) begin
                pending_echo <= 0;
                pending_manual <= 0;
            end
            if (key_pulse && SW[9]) begin
                manual_char <= SW[7:0];
                pending_manual <= 1;
            end
            if (rx_ready) begin
                last_char <= rx_data;
                state <= S_DISPLAY;
                elapsed <= 0;
                if (!SW[9]) pending_echo <= 1;
            end else if (state == S_DISPLAY) begin
                if (elapsed == HOLD_TICKS - 1) begin
                    state <= S_IDLE;
                    elapsed <= 0;
                end else elapsed <= elapsed + 1'b1;
            end
        end
    end

    wire [7:0] segments;
    char2seg decoder(.char(last_char), .HEX0(segments));
    assign HEX0 = (state == S_DISPLAY) ? segments : 8'hFF;
    assign LEDR[7:0] = (state == S_DISPLAY) ? last_char : 8'h00;
    assign LEDR[8] = (state == S_DISPLAY);
    assign LEDR[9] = tx_busy;
endmodule

module uart_button #(parameter DEBOUNCE_CYCLES = 500000)(input clk, reset, key_n, output reg pulse = 0);
    reg sync1 = 1, sync2 = 1, stable = 1;
    reg [18:0] count = 0;
    always @(posedge clk) begin
        if (reset) begin
            sync1 <= 1; sync2 <= 1; stable <= 1;
            count <= 0; pulse <= 0;
        end else begin
            sync1 <= key_n;
            sync2 <= sync1;
            pulse <= 0;
            if (sync2 == stable) count <= 0;
            else if (count == DEBOUNCE_CYCLES - 1) begin
                count <= 0;
                stable <= sync2;
                if (!sync2) pulse <= 1;
            end else count <= count + 1'b1;
        end
    end
endmodule
