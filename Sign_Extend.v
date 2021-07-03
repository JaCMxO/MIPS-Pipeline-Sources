/******************************************************************
* Description
*	This module performes a sign-extend operation that is need with
*	in instruction like andi or ben.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Sign_Extend
(   
	input logic_ext_i,
	input [15:0]  data_i,
	output reg [31:0] sign_extend_o
);

always @(data_i or logic_ext_i) begin
	if(logic_ext_i)
		sign_extend_o = {{16{1'b0}}, data_i[15:0]};
	else
		sign_extend_o = {{16{data_i[15]}},data_i[15:0]};
end

endmodule // signExtend
