/******************************************************************
* Description
*	This is the verifaction envioroment ofr testeting the basic MIPS
*	procesor.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
`timescale 1ns/1ns

module MIPS_Processor_TB;
reg clk_tb = 0;
reg reset_tb = 0; 
wire [31:0] alu_result_tb;  

  
  
MIPS_Processor
DUV
(
	.clk(clk_tb),
	.reset(reset_tb),
	.alu_result_o(alu_result_tb)

);
/*********************************************************/
initial // Clock generator
  begin
    forever #12.5 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset generator
	#20 reset_tb = 1;
end
/*********************************************************/

endmodule
