/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Control
(
	input [5:0]opcode_i,
	
	output logic_ext_o,
	output jal_ctl_o,
	output [1:0] jmp_ctl_o,
	output reg_dst_o,
	output branch_eq_o,
	output branch_ne_o,
	output mem_read_o,
	output mem_to_reg_o,
	output mem_write_o,
	output alu_src_o,
	output reg_write_o,
	output [2:0]alu_op_o
);


localparam R_TYPE		= 6'h0;
localparam I_TYPE_ADDI	= 6'h8;
localparam I_TYPE_ORI	= 6'hd;
localparam I_TYPE_ANDI 	= 6'hc;
localparam I_TYPE_LUI	= 6'hf;
localparam I_TYPE_SW 	= 6'h2b;
localparam I_TYPE_LW 	= 6'h23;
localparam I_TYPE_BEQ	= 6'h4;
localparam I_TYPE_BNE	= 6'h5;
localparam J_TYPE_J 	= 6'h2;
localparam J_TYPE_JAL 	= 6'h3;



reg [14:0] control_values_r;

always@(opcode_i) begin

	case(opcode_i)
	
		R_TYPE     	: control_values_r = 15'b00_00_1_001_00_00_111;
		I_TYPE_ADDI : control_values_r = 15'b00_00_0_101_00_00_100;
		I_TYPE_ORI	: control_values_r = 15'b10_00_0_101_00_00_101;
		I_TYPE_ANDI	: control_values_r = 15'b10_00_0_101_00_00_001;
		I_TYPE_LUI	: control_values_r = 15'b00_00_0_101_00_00_110;
		I_TYPE_SW	: control_values_r = 15'b00_00_0_110_01_00_011;
		I_TYPE_LW	: control_values_r = 15'b00_00_0_111_10_00_011;
		I_TYPE_BEQ	: control_values_r = 15'b00_00_0_000_00_01_010;
		I_TYPE_BNE	: control_values_r = 15'b00_00_0_000_00_10_010;
		J_TYPE_J 	: control_values_r = 15'b00_01_0_000_00_00_000;
		J_TYPE_JAL	: control_values_r = 15'b01_01_0_001_00_00_000;

		default:
			control_values_r = 15'b00_00_0_000_00_00_000;
	endcase
		
end	

assign logic_ext_o	= control_values_r[14];
assign jal_ctl_o	= control_values_r[13];

assign jmp_ctl_o	= control_values_r[12:11];

assign reg_dst_o	= control_values_r[10];

assign alu_src_o	= control_values_r[9];
assign mem_to_reg_o = control_values_r[8];
assign reg_write_o	= control_values_r[7];

assign mem_read_o	= control_values_r[6];
assign mem_write_o	= control_values_r[5];

assign branch_ne_o	= control_values_r[4];
assign branch_eq_o	= control_values_r[3];

assign alu_op_o		= control_values_r[2:0];	

endmodule


