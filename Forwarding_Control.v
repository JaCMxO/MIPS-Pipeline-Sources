/******************************************************************
* Description
*	This is the forwarding control module capable of forward data to
*	meet instructions and reduce the nop usage.
*	1.0
* Author:
*	Jaime Alberto Camacho Ortiz
* email:
*	ie725668@iteso.mx
* Date:
*	06.07.2021
******************************************************************/

module Forwarding_Control (
	input ctl_reg_write_EXMEM_i,
	input ctl_reg_write_MEMWB_i,
	input [4:0] reg_rs_IDEX_i,
	input [4:0] reg_rt_IDEX_i,
	input [4:0] reg_dest_EXMEM_i,
	input [4:0] reg_dest_MEMWB_i,

	output reg [1:0] forward_A_o,
	output reg [1:0] forward_B_o
);

always
@ (
	ctl_reg_write_EXMEM_i or 
	ctl_reg_write_MEMWB_i or 
	reg_rs_IDEX_i or 
	reg_rt_IDEX_i or 
	reg_dest_EXMEM_i or 
	reg_dest_MEMWB_i
)
begin
	forward_A_o = 2'b00;
	forward_B_o = 2'b00;

	if
	(
		ctl_reg_write_EXMEM_i &&
		(reg_dest_EXMEM_i != 0) &&
		(reg_dest_EXMEM_i == reg_rs_IDEX_i)
	) begin forward_A_o = 2'b10; end
	else if
	(
		ctl_reg_write_MEMWB_i && 
		(reg_dest_MEMWB_i != 0) && 
		(reg_dest_MEMWB_i == reg_rs_IDEX_i)
	) begin forward_A_o = 2'b01; end


	if
	(
		ctl_reg_write_EXMEM_i && 
		(reg_dest_EXMEM_i != 0) && 
		(reg_dest_EXMEM_i == reg_rt_IDEX_i)
	) begin forward_B_o = 2'b10; end
	else if
	(
		ctl_reg_write_MEMWB_i && 
		(reg_dest_MEMWB_i != 0) && 
		(reg_dest_MEMWB_i == reg_rt_IDEX_i)
	) begin	forward_B_o = 2'b01; end

end

endmodule
