/******************************************************************
* Description
*	This is a  an 2to1 multiplexer that can be parameterized in its bit-width.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/

module Multiplexer_2_to_1
#(
	parameter N_BITS=32
)
(
	input selector_i,
	input [N_BITS-1:0] data_0_i,
	input [N_BITS-1:0] data_1_i,
	
	output reg [N_BITS-1:0] mux_o

);

	always@(selector_i, data_1_i, data_0_i) begin
		if(selector_i)
			mux_o = data_1_i;
		else
			mux_o = data_0_i;
	end

endmodule
