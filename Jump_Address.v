module Jump_Address (
	input [31:0] pc_plus_4_i,
	input [25:0] address_i,
	output [31:0] jmp_address_o
);

assign jmp_address_o = {pc_plus_4_i[31:28], address_i, 2'b00};

endmodule