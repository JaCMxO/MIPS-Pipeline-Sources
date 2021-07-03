/******************************************************************
* Description
*	This the basic register that is used in the register file
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Register
#(
	parameter N_BITS = 32,
	parameter RST_VALUE = 0
)
(
	input clk,
	input reset,
	input enable,
	input  [N_BITS - 1 : 0] data_i,
	
	
	output reg [N_BITS - 1:0] data_o
);

always@(negedge reset or posedge clk) begin
	if(reset==0)
		data_o <= RST_VALUE;
	else	
		if(enable == 1)
			data_o <= data_i;
end

endmodule
