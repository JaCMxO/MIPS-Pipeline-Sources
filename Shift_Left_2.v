/******************************************************************
* Description
*	This performs a shift left opeartion in roder to calculate the brances.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Shift_Left_2 
(   
	input [31:0]  data_i,
   output reg [31:0] data_o

);
   always @ (data_i)
     data_o = {data_i[29:0], 1'b0, 1'b0};

endmodule // leftShift2