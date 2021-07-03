/******************************************************************
* Description
*	This is  a ROM memory that represents the program memory. 
* 	Internally, the memory is read without a signal clock. The initial 
*	values (program) of this memory are written from a file named text.dat.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Program_Memory
#
(
	parameter MEMORY_DEPTH = 32,
	parameter DATA_WIDTH = 32
)
(
	input [(DATA_WIDTH-1):0] address_i,
	output reg [(DATA_WIDTH-1):0] instruction_o
);

wire [(DATA_WIDTH-1):0] real_address_r;

//shift 2 times right (divide by 4) and subtract 0x0040_0000 from logical address
assign real_address_r = {2'b0, address_i[(DATA_WIDTH-1):23], 1'b0, address_i[21:2]};


	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[MEMORY_DEPTH-1:0];

	initial
	begin
		$readmemh("/home/jaime/MIPS/MIPS-Processor-Sources/text.dat", rom);
	end

	always @ (real_address_r)
	begin
		instruction_o = rom[real_address_r];
	end

endmodule
