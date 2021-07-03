/******************************************************************
* Description
*	This is the data memory for the MIPS processor
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/

module Data_Memory 
#(	parameter DATA_WIDTH=8,
	parameter MEMORY_DEPTH = 1024

)
(
	input [DATA_WIDTH-1:0] write_data_i,
	input [DATA_WIDTH-1:0]  address_i,
	input mem_write_i,mem_read_i, clk,
	output  [DATA_WIDTH-1:0]  data_o
);

	wire [DATA_WIDTH-1:0] real_address_w; 
	assign real_address_w = {2'b00, address_i[DATA_WIDTH-1:29], 1'b0, address_i[27:17], 1'b0, address_i[15:2]};

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
	wire [DATA_WIDTH-1:0] read_data_aux;

	always @ (posedge clk)
	begin
		// Write
		if (mem_write_i)
			ram[real_address_w] <= write_data_i;
	end
	assign read_data_aux = ram[real_address_w];
	assign data_o = {DATA_WIDTH{mem_read_i}} & read_data_aux;

endmodule
