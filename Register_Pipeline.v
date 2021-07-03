/******************************************************************
* Description
*	This is the pipeline register that is used to implement pipeline
*	1.0
* Author:
*	Jaime Alberto Camacho Ortiz
* email:
*	ie725668@iteso.mx
* Date:
*	02.07.2021
******************************************************************/
module Register_Pipeline
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

always@(negedge reset or negedge clk) begin
	if(reset==0)
		data_o <= RST_VALUE;
	else	
		if(enable == 1)
			data_o <= data_i;
end

endmodule
