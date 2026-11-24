`timescale 1ns/1ps

module tb_vsm;

    reg clk = 0;
    reg reset = 1;
    reg [3:0] user_in = 4'h4;

    wire [3:0] bus;
    wire [3:0] aa, bb;
    wire [3:0] output_data;
    wire [3:0] instruction, instr_data, opcode;
    wire [3:0] pc;
    wire [7:0] rom_word;

    wire latch_a, enable_a, latch_b;
    wire enable_alu, add_sub, enable_in, enable_out;
    wire load_instr, enable_instr, enable_count, carry;

    reg [3:0] expected [0:2];

    Accumulator_A AccA(
        .MainClock(clk), .ClearA(reset),
        .LatchA(latch_a), .EnableA(enable_a),
        .A(bus), .IB_BUS(bus), .AluA(aa)
    );

    Accumulator_B AccB(
        .MainClock(clk), .ClearB(reset),
        .LatchB(latch_b), .B(bus), .AluB(bb)
    );

    Arithmetic_Unit ALU(
        .EnableALU(enable_alu), .AddSub(add_sub),
        .A(aa), .B(bb), .Carry(carry), .IB_ALU(bus)
    );

    InRegister InReg(
        .EnableIN(enable_in), .DataIn(user_in), .IB_BUS(bus)
    );

    OutRegister OutReg(
        .MainClock(clk), .MainReset(reset),
        .EnableOut(enable_out), .IB_BUS(bus),
        .rOut(output_data)
    );

    InstructionReg InstrReg(
        .MainClock(clk), .ClearInstr(reset),
        .LatchInstr(load_instr), .EnableInstr(enable_instr),
        .Data(instr_data), .Instr(instruction),
        .ToInstr(opcode), .IB_BUS(bus)
    );

    ProgramCounter PC(
        .MainClock(clk), .EnableCount(enable_count),
        .ClearCounter(reset), .Counter(pc)
    );

    ROM_Nx8 ROM(
        .address(pc[2:0]), .data(rom_word)
    );

    assign {instruction, instr_data} = rom_word;

    FSM_MicroInstr FSM(
        .clk(clk), .reset(reset), .IB_BUS(bus),
        .LatchA(latch_a), .EnableA(enable_a),
        .LatchB(latch_b), .EnableALU(enable_alu),
        .AddSub(add_sub), .EnableIN(enable_in),
        .EnableOut(enable_out), .LoadInstr(load_instr),
        .EnableInstr(enable_instr), .ToInstr(opcode),
        .EnableCount(enable_count)
    );

    always #5 clk = ~clk;

    reg [3:0] previous_output = 0;
    integer cycle;
    integer outputs_seen = 0;

    initial begin
        expected[0] = 4'h7;
        expected[1] = 4'hF;
        expected[2] = 4'h7;

        repeat (3) @(posedge clk);
        @(negedge clk);
        reset = 0;

        for (cycle = 0; cycle < 50; cycle = cycle + 1) begin
            @(posedge clk);
            #1;

            if (output_data !== previous_output) begin
                if (outputs_seen >= 3 ||
                    output_data !== expected[outputs_seen]) begin
                    $display("FAIL: Unexpected output %h at cycle %0d",
                             output_data, cycle);
                    $finish;
                end

                $display("PASS: Output %0d = %h at cycle %0d",
                         outputs_seen + 1, output_data, cycle);

                outputs_seen = outputs_seen + 1;
                previous_output = output_data;
            end
        end

        if (outputs_seen == 3)
            $display("PASS: All outputs matched 7, F, 7");
        else
            $display("FAIL: Only %0d of 3 outputs observed",
                     outputs_seen);

        $finish;
    end

endmodule
