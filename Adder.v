/******************************************************************
* Description
*	This is a  an adder that can be parameterized in its bit-width.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/

module Adder
#
(
	parameter N_BITS = 32
)
(
	input [N_BITS-1:0] data_0_i,
	input [N_BITS-1:0] data_1_i,
	
	output [N_BITS-1:0] result_o
);

assign result_o = data_1_i + data_0_i;


endmodule
