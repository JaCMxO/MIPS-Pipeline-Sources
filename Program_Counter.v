/******************************************************************
* Description
*	This is a register of 32-bit that corresponds to the PC counter. 
*	This register does not have an enable signal.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/

module Program_Counter
#(
	parameter N_BITS = 32
)
(
	input clk,
	input reset,
	input  [N_BITS-1:0] new_pc_i,
	
	
	output reg [N_BITS-1:0] pc_value_o
);

always@(negedge reset or posedge clk) begin
	if(reset==0)
		pc_value_o <= 32'h0040_0000;
	else	
		pc_value_o<=new_pc_i;
end

endmodule