`default_nettype none

module FSM_MicroInstr #
(
	parameter N = 4
)
(
	input clk,
	input reset,
	input [N-1:0] IB_BUS,

	output reg LatchA,
	output reg EnableA,
	output reg LatchB,
	output reg EnableALU,
	output reg AddSub,
	output reg EnableIN,
	output reg EnableOut,
	output reg LoadInstr,
	output reg EnableInstr,
	input [N-1:0]	ToInstr,
	output reg EnableCount
);

	reg [2:0] state, next_state;

	localparam [2:0] IDLE = 3'd0, PHASE_1 = 3'd1, PHASE_2 = 3'd2, PHASE_3 = 3'd3, PHASE_4 = 3'd4;

	always @(posedge clk) begin
		if(reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @(*) begin

		next_state = state;

		case(state)

			IDLE:
				begin

					next_state = PHASE_1;
				end

			PHASE_1:
				begin

					next_state = PHASE_2;
				end

			PHASE_2:
				begin

					next_state = PHASE_3;
				end

			PHASE_3:
				begin

					next_state = PHASE_4;
				end

			PHASE_4:
				begin

					next_state = PHASE_1;
				end

			default: ;

		endcase
	end

	always @(*) begin

		LoadInstr 	= 1'b0;
		EnableInstr = 1'b0;
		LatchB 		= 1'b0;
		LatchA 		= 1'b0;
		EnableALU 	= 1'b0;
		EnableCount = 1'b0;
		AddSub		= 1'b0;
		EnableIN		= 1'b0;
		EnableA		= 1'b0;
		EnableOut	= 1'b0;

		case(state)

			IDLE:
				begin

				end

			PHASE_1:
				begin

					LoadInstr = 1'b1;
				end

			PHASE_2:
				begin

					EnableCount = 1'b1;
					EnableInstr = 1'b1;
				end

			PHASE_3:
				begin

					case(ToInstr)

						4'b0000:
							begin

							end

						4'b0001:
							begin
								LatchB 		= 1'b1;
								EnableInstr = 1'b1;
							end

						4'b0010:
							begin
								LatchB 		= 1'b1;
								EnableInstr = 1'b1;
							end

						4'b0011:
							begin
								EnableOut 	= 1'b1;
								EnableA 		= 1'b1;
							end

						4'b0100:
							begin
								LatchA 	= 1'b1;
								EnableIN = 1'b1;
							end

						4'b0101:
							begin
								LatchA 		= 1'b1;
								EnableInstr = 1'b1;
							end

					endcase

				end

			PHASE_4:
				begin

					case(ToInstr)

						4'b0000:
							begin

							end

						4'b0001:
							begin
								LatchA 		= 1'b1;
								EnableALU 	= 1'b1;
							end

						4'b0010:
							begin
								LatchA 		= 1'b1;
								EnableALU 	= 1'b1;
								AddSub 		= 1'b1;
							end

						4'b0011:
							begin

							end

						4'b0100:
							begin

							end

						4'b0101:
							begin

							end

					endcase

				end

		endcase
	end

endmodule

`default_nettype wire
