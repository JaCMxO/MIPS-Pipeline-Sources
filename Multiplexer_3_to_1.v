/******************************************************************
* Description
*	This is a 3to1 multiplexer that can be parameterized in its bit-width.
*	1.0
* Author:
*	Jaime Alberto Camacho Ortiz
* email:
*	ie725668@iteso.mx
* Date:
*	22.06.2020
******************************************************************/

module Multiplexer_3_to_1
#(
	parameter N_BITS=32
)
(
	input [1:0] selector_i,
	input [N_BITS-1:0] data_0_i,
	input [N_BITS-1:0] data_1_i,
	input [N_BITS-1:0] data_2_i,
	
	output [N_BITS-1:0] mux_o
);

reg [N_BITS-1:0] output_aux_r;

localparam DATA_0 = 2'b00;
localparam DATA_1 = 2'b01;
localparam DATA_2 = 2'b10;

	always@(selector_i or data_1_i or data_0_i or data_2_i) begin
		case (selector_i)
			DATA_0	: output_aux_r = data_0_i;
			DATA_1	: output_aux_r = data_1_i;
			DATA_2	: output_aux_r = data_2_i;
			default	: output_aux_r = data_0_i;
		endcase
	end

assign mux_o = output_aux_r;

endmodule
