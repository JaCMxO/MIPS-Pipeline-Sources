
module Mux_Register_File
#(
	parameter N=32
)
(
	input [4:0] selector_i,

	input [N-1:0] data_0_i,
	input [N-1:0] data_1_i,
	input [N-1:0] data_2_i,
	input [N-1:0] data_3_i,
	input [N-1:0] data_4_i,
	input [N-1:0] data_5_i,
	input [N-1:0] data_6_i,
	input [N-1:0] data_7_i,
	input [N-1:0] data_8_i,
	input [N-1:0] data_9_i,
	input [N-1:0] data_10_i,
	input [N-1:0] data_11_i,
	input [N-1:0] data_12_i,
	input [N-1:0] data_13_i,
	input [N-1:0] data_14_i,
	input [N-1:0] data_15_i,
	input [N-1:0] data_16_i,
	input [N-1:0] data_17_i,
	input [N-1:0] data_18_i,
	input [N-1:0] data_19_i,
	input [N-1:0] data_20_i,
	input [N-1:0] data_21_i,
	input [N-1:0] data_22_i,
	input [N-1:0] data_23_i,
	input [N-1:0] data_24_i,
	input [N-1:0] data_25_i,
	input [N-1:0] data_26_i,
	input [N-1:0] data_27_i,
	input [N-1:0] data_28_i,
	input [N-1:0] data_29_i,
	input [N-1:0] data_30_i,
	input [N-1:0] data_31_i,
	
	output reg [N-1:0] mux_o
	
);

always@(*)begin
	case(selector_i)
		0: mux_o = data_0_i;
		1: mux_o = data_1_i;
		2: mux_o = data_2_i;
		3: mux_o = data_3_i;
		4: mux_o = data_4_i;
		5: mux_o = data_5_i;
		6: mux_o = data_6_i;
		7: mux_o = data_7_i;
		8: mux_o = data_8_i;
		9: mux_o = data_9_i;
		10: mux_o = data_10_i;
		11: mux_o = data_11_i;
		12: mux_o = data_12_i;
		13: mux_o = data_13_i;
		14: mux_o = data_14_i;
		15: mux_o = data_15_i;
		16: mux_o = data_16_i;
		17: mux_o = data_17_i;
		18: mux_o = data_18_i;
		19: mux_o = data_19_i;
		20: mux_o = data_20_i;
		21: mux_o = data_21_i;
		22: mux_o = data_22_i;
		23: mux_o = data_23_i;
		24: mux_o = data_24_i;
		25: mux_o = data_25_i;
		26: mux_o = data_26_i;
		27: mux_o = data_27_i;
		28: mux_o = data_28_i;
		29: mux_o = data_29_i;
		30: mux_o = data_30_i;
		31: mux_o = data_31_i;
	endcase
end

endmodule



