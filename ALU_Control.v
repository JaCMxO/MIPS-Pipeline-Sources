/******************************************************************
* Description
*	This is the control unit for the ALU. It receves an signal called 
*	ALUOp from the control unit and a signal called ALUFunction from
*	the intrctuion field named function.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module ALU_Control
(
	input [2:0] alu_op_i,
	input [5:0] alu_function_i,
	
	output reg [1:0] jmp_ctl_o,
	output [3:0] alu_operation_o

);


localparam R_TYPE_ADD		= 9'b111_100000;
localparam R_TYPE_SUB 		= 9'b111_100010;
localparam R_TYPE_OR 		= 9'b111_100101;
localparam R_TYPE_AND 		= 9'b111_100100;
localparam R_TYPE_NOR		= 9'b111_100111;
localparam R_TYPE_JR 		= 9'b111_001000;
localparam I_TYPE_ADDI		= 9'b100_xxxxxx;
localparam I_TYPE_ORI 		= 9'b101_xxxxxx;
localparam I_TYPE_ANDI 		= 9'b001_xxxxxx;
localparam I_TYPE_LUI		= 9'b110_xxxxxx;
localparam I_TYPE_SLW		= 9'b011_xxxxxx;
localparam I_TYPE_BNE_BEQ	= 9'b010_xxxxxx;


reg [3:0] alu_control_values_r;
wire [8:0] selector_w;

assign selector_w = {alu_op_i, alu_function_i};

always@(selector_w)begin

	casex(selector_w)
	
		R_TYPE_ADD		: begin alu_control_values_r = 4'b0011; jmp_ctl_o = 2'b00; end
		I_TYPE_ADDI		: begin alu_control_values_r = 4'b0011; jmp_ctl_o = 2'b00; end
		I_TYPE_ORI		: begin alu_control_values_r = 4'b0010; jmp_ctl_o = 2'b00; end
		R_TYPE_SUB		: begin alu_control_values_r = 4'b0100; jmp_ctl_o = 2'b00; end
		I_TYPE_LUI		: begin alu_control_values_r = 4'b0101; jmp_ctl_o = 2'b00; end
		R_TYPE_OR		: begin alu_control_values_r = 4'b0010; jmp_ctl_o = 2'b00; end
		R_TYPE_AND		: begin alu_control_values_r = 4'b0110; jmp_ctl_o = 2'b00; end
		I_TYPE_ANDI		: begin alu_control_values_r = 4'b0110; jmp_ctl_o = 2'b00; end
		R_TYPE_NOR		: begin alu_control_values_r = 4'b0111; jmp_ctl_o = 2'b00; end
		I_TYPE_SLW		: begin alu_control_values_r = 4'b0011; jmp_ctl_o = 2'b00; end
		I_TYPE_BNE_BEQ	: begin alu_control_values_r = 4'b0100; jmp_ctl_o = 2'b00; end
		R_TYPE_JR		: begin alu_control_values_r = 4'b1001; jmp_ctl_o = 2'b10; end

		default: begin alu_control_values_r = 4'b1001; jmp_ctl_o = 2'b00; end
	endcase
	
end


assign alu_operation_o = alu_control_values_r;

endmodule
