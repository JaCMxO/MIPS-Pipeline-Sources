/******************************************************************
* Description
*	This performs a shift opeartion with the branch register
*	1.0
* Author:
*	Jaime Alberto Camacho Ortiz
* email:
*	ie725668@iteso.mx
* Date:
*	19.06.2021
******************************************************************/
module ShiftLogic(
	input [5:0] sl_opcode_i,
	input [4:0] sl_shamt_i,
	input [5:0] sl_func_i,
	input [31:0] sl_data_i,

	output [31:0] sl_result_o,
	output sl_shift_o
);

localparam SLL = 12'b000000_000000;
localparam SRL = 12'b000000_000010;


reg [31:0] shifted_result_r;
reg shift_flag_r;
wire [11:0] selector_w;

assign selector_w = {sl_opcode_i, sl_func_i};

always @(selector_w or sl_data_i or sl_shamt_i) begin
	case (selector_w)
		SLL :	//Shift Left Logic
			begin
				shifted_result_r = sl_data_i << sl_shamt_i;
				shift_flag_r = 1;
			end

		SRL :	//Shift Right Logic
			begin
				shifted_result_r = sl_data_i >> sl_shamt_i;
				shift_flag_r = 1;
			end

		default :
			begin
				shifted_result_r = 0;
				shift_flag_r = 0;
			end

	endcase
end

assign sl_result_o = shifted_result_r;
assign sl_shift_o = shift_flag_r;

endmodule
