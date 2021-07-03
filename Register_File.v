/******************************************************************
* Description
*	This is  module represents the register file where the registers 
*	like $s0-$s7 are store. 
*	of MIPS processor.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/
module Register_File
(
	input  clk,
	input  reset,
	input 			reg_write_i,
	input  [4:0] 	write_register_i,
	input  [4:0] 	read_register_1_i,
	input  [4:0] 	read_register_2_i,
	input  [31:0] 	write_data_i,
	
	output [31:0] 	read_data_1_o,
	output [31:0] 	read_data_2_o

);

localparam N_BITS = 32;


wire [32*N_BITS - 1 : 0]intercnection_w;
wire [31:0] select_register_w;


Decoder_Register_File
DECODER_REG_FILE
(
	.write_register_i(write_register_i),
	.select_register_o(select_register_w)
);

/****************************************************************/
/****************************************************************/
/****************************************************************/
/****************************************************************/
/****************************************************************/

Register
Zero
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[0]&reg_write_i),
	.data_i(0),
	.data_o(intercnection_w[N_BITS - 1 : 0])
);


	
	
	
Register
at
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[1]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[2*N_BITS-1:1*N_BITS])
);	
	

	
Register
v0
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[2]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[3*N_BITS-1:2*N_BITS])
);	


Register
v1
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[3]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[4*N_BITS-1:3*N_BITS])
);		
	


Register
a0
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[4]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[5*N_BITS-1:4*N_BITS])
);



Register
a1
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[5]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[6*N_BITS-1:5*N_BITS])
);



Register
a2
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[6]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[7*N_BITS-1:6*N_BITS])
);




Register
a3
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[7]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[8*N_BITS-1:7*N_BITS])
);



Register
t0
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[8]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[9*N_BITS-1:8*N_BITS])
);



Register
t1
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[9]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[10*N_BITS-1:9*N_BITS])
);



Register
t2
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[10]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[11*N_BITS-1:10*N_BITS])
);



Register
t3
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[11]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[12*N_BITS-1:11*N_BITS])
);



Register
t4
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[12]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[13*N_BITS-1:12*N_BITS])
);



Register
t5
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[13]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[14*N_BITS-1:13*N_BITS])
);



Register
t6
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[14]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[15*N_BITS-1:14*N_BITS])
);



Register
t7
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[15]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[16*N_BITS-1:15*N_BITS])
);


Register
s0
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[16]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[17*N_BITS-1:16*N_BITS])
);



Register
s1
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[17]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[18*N_BITS-1:17*N_BITS])
);



Register
s2
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[18]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[19*N_BITS-1:18*N_BITS])
);



Register
s3
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[19]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[20*N_BITS-1:19*N_BITS])
);




Register
s4
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[20]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[21*N_BITS-1:20*N_BITS])
);




Register
s5
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[21]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[22*N_BITS-1:21*N_BITS])
);




Register
s6
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[22]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[23*N_BITS-1:22*N_BITS])
);




Register
s7
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[23]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[24*N_BITS-1:23*N_BITS])
);



Register
t8
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[24]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[25*N_BITS-1:24*N_BITS])
);

Register
t9
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[25]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[26*N_BITS-1:25*N_BITS])
);



Register
k0
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[26]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[27*N_BITS-1:26*N_BITS])
);
	


Register
k1
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[27]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[28*N_BITS-1:27*N_BITS])
);	



Register
gp
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[28]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[29*N_BITS-1:28*N_BITS])
);


Register
#(
	.RST_VALUE(32'h1001_03fc)
)
sp
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[29]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[30*N_BITS-1:29*N_BITS])
);




Register
fp
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[30]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[31*N_BITS-1:30*N_BITS])
);



Register
ra
(
	.clk(clk),
	.reset(reset),
	.enable(select_register_w[31]&reg_write_i),
	.data_i(write_data_i),
	.data_o(intercnection_w[32*N_BITS-1:31*N_BITS])
);




Mux_Register_File
#(
	.N(32)
)
MUXRegister1
(
	.selector_i(read_register_1_i),

	.data_0_i(intercnection_w[1*N_BITS-1:0*N_BITS]),
	.data_1_i(intercnection_w[2*N_BITS-1:1*N_BITS]),
	.data_2_i(intercnection_w[3*N_BITS-1:2*N_BITS]),
	.data_3_i(intercnection_w[4*N_BITS-1:3*N_BITS]),
	.data_4_i(intercnection_w[5*N_BITS-1:4*N_BITS]),
	.data_5_i(intercnection_w[6*N_BITS-1:5*N_BITS]),
	.data_6_i(intercnection_w[7*N_BITS-1:6*N_BITS]),
	.data_7_i(intercnection_w[8*N_BITS-1:7*N_BITS]),
	.data_8_i(intercnection_w[9*N_BITS-1:8*N_BITS]),
   .data_9_i(intercnection_w[10*N_BITS-1:9*N_BITS]),
	.data_10_i(intercnection_w[11*N_BITS-1:10*N_BITS]),
	.data_11_i(intercnection_w[12*N_BITS-1:11*N_BITS]),
	.data_12_i(intercnection_w[13*N_BITS-1:12*N_BITS]),
	.data_13_i(intercnection_w[14*N_BITS-1:13*N_BITS]),
	.data_14_i(intercnection_w[15*N_BITS-1:14*N_BITS]),
	.data_15_i(intercnection_w[16*N_BITS-1:15*N_BITS]),
	.data_16_i(intercnection_w[17*N_BITS-1:16*N_BITS]),
	.data_17_i(intercnection_w[18*N_BITS-1:17*N_BITS]),
	.data_18_i(intercnection_w[19*N_BITS-1:18*N_BITS]),
	.data_19_i(intercnection_w[20*N_BITS-1:19*N_BITS]),
	.data_20_i(intercnection_w[21*N_BITS-1:20*N_BITS]),
	.data_21_i(intercnection_w[22*N_BITS-1:21*N_BITS]),
	.data_22_i(intercnection_w[23*N_BITS-1:22*N_BITS]),
	.data_23_i(intercnection_w[24*N_BITS-1:23*N_BITS]),
	.data_24_i(intercnection_w[25*N_BITS-1:24*N_BITS]),
	.data_25_i(intercnection_w[26*N_BITS-1:25*N_BITS]),
	.data_26_i(intercnection_w[27*N_BITS-1:26*N_BITS]),
	.data_27_i(intercnection_w[28*N_BITS-1:27*N_BITS]),
	.data_28_i(intercnection_w[29*N_BITS-1:28*N_BITS]),
	.data_29_i(intercnection_w[30*N_BITS-1:29*N_BITS]),
	.data_30_i(intercnection_w[31*N_BITS-1:30*N_BITS]),
	.data_31_i(intercnection_w[32*N_BITS-1:31*N_BITS]),
	
	.mux_o(read_data_1_o)
);


Mux_Register_File
#(
	.N(32)
)
MUXRegister2
(
	.selector_i(read_register_2_i),

		.data_0_i(intercnection_w[1*N_BITS-1:0*N_BITS]),
	.data_1_i(intercnection_w[2*N_BITS-1:1*N_BITS]),
	.data_2_i(intercnection_w[3*N_BITS-1:2*N_BITS]),
	.data_3_i(intercnection_w[4*N_BITS-1:3*N_BITS]),
	.data_4_i(intercnection_w[5*N_BITS-1:4*N_BITS]),
	.data_5_i(intercnection_w[6*N_BITS-1:5*N_BITS]),
	.data_6_i(intercnection_w[7*N_BITS-1:6*N_BITS]),
	.data_7_i(intercnection_w[8*N_BITS-1:7*N_BITS]),
	.data_8_i(intercnection_w[9*N_BITS-1:8*N_BITS]),
   .data_9_i(intercnection_w[10*N_BITS-1:9*N_BITS]),
	.data_10_i(intercnection_w[11*N_BITS-1:10*N_BITS]),
	.data_11_i(intercnection_w[12*N_BITS-1:11*N_BITS]),
	.data_12_i(intercnection_w[13*N_BITS-1:12*N_BITS]),
	.data_13_i(intercnection_w[14*N_BITS-1:13*N_BITS]),
	.data_14_i(intercnection_w[15*N_BITS-1:14*N_BITS]),
	.data_15_i(intercnection_w[16*N_BITS-1:15*N_BITS]),
	.data_16_i(intercnection_w[17*N_BITS-1:16*N_BITS]),
	.data_17_i(intercnection_w[18*N_BITS-1:17*N_BITS]),
	.data_18_i(intercnection_w[19*N_BITS-1:18*N_BITS]),
	.data_19_i(intercnection_w[20*N_BITS-1:19*N_BITS]),
	.data_20_i(intercnection_w[21*N_BITS-1:20*N_BITS]),
	.data_21_i(intercnection_w[22*N_BITS-1:21*N_BITS]),
	.data_22_i(intercnection_w[23*N_BITS-1:22*N_BITS]),
	.data_23_i(intercnection_w[24*N_BITS-1:23*N_BITS]),
	.data_24_i(intercnection_w[25*N_BITS-1:24*N_BITS]),
	.data_25_i(intercnection_w[26*N_BITS-1:25*N_BITS]),
	.data_26_i(intercnection_w[27*N_BITS-1:26*N_BITS]),
	.data_27_i(intercnection_w[28*N_BITS-1:27*N_BITS]),
	.data_28_i(intercnection_w[29*N_BITS-1:28*N_BITS]),
	.data_29_i(intercnection_w[30*N_BITS-1:29*N_BITS]),
	.data_30_i(intercnection_w[31*N_BITS-1:30*N_BITS]),
	.data_31_i(intercnection_w[32*N_BITS-1:31*N_BITS]),
	
	.mux_o(read_data_2_o)
);
endmodule
