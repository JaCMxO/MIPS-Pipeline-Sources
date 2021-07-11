/******************************************************************
* Description
*	This is the hazard detection module capable of stalling the
*	processor to execute lw, sw, bne, beq, j, jal, jr instructions
*	1.0
* Author:
*	Jaime Alberto Camacho Ortiz
* email:
*	ie725668@iteso.mx
* Date:
*	08.07.2021
******************************************************************/

module Hazard_Detection (
	input ctl_mem_read_IDEX_i,
	input ctl_jmp_ctl_i,		//second bit of jmp_ctl
	input [1:0] ctl_alu_ctl_jmp_ctl_i,
	input [4:0] reg_rt_IDEX_i,
	input [4:0] reg_rs_IFID_i,
	input [4:0] reg_rt_IFID_i,

	output reg PC_write_o,
	output reg IFID_write_o,
	output reg ctl_flush_o,
	output reg IFID_flush_o,
	output reg IDEX_flush_o
);

always
@ (
	ctl_mem_read_IDEX_i,
	reg_rt_IDEX_i,
	reg_rs_IFID_i,
	reg_rt_IFID_i,
	ctl_jmp_ctl_i,
	ctl_alu_ctl_jmp_ctl_i
)
begin
	PC_write_o = 1'b1;
	IFID_write_o = 1'b1;
	ctl_flush_o = 1'b1;
	IFID_flush_o = 1'b1;
	IDEX_flush_o = 1'b1;

	if
	(
		ctl_mem_read_IDEX_i &&
		(
			(reg_rt_IDEX_i == reg_rs_IFID_i) ||
			(reg_rt_IDEX_i == reg_rt_IFID_i)
		)
	)
	begin
		PC_write_o = 1'b0;
		IFID_write_o = 1'b0;
		ctl_flush_o = 1'b0;
	end

	if
	(
		(ctl_alu_ctl_jmp_ctl_i != 0) ||		//if is jr instruction
		(ctl_jmp_ctl_i != 0)				//if is jal or j instruction
	)
	begin
		IFID_flush_o = 1'b0;
		IDEX_flush_o = 1'b0;
	end

end

endmodule
