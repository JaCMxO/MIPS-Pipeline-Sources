/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 256
)
(
	// Inputs
	input clk,
	input reset,
	// Output
	output [31:0] alu_result_o
);
//******************************************************************/
//******************************************************************/
// Data types to connect modules

wire reg_dst_w;
wire alu_rc_w;
wire reg_write_w;
wire zero_w;
wire mem_to_reg_w;
wire mem_read_w;
wire mem_write_w;
wire shift_w;
wire branch_ne_w;
wire branch_eq_w;
wire is_branch_w;
wire jal_ctl_w;
wire logic_ext_w;
wire [1:0] jmp_ctl_ctl_w;
wire [1:0] jmp_ctl_w;
wire [1:0] jmp_ctl_alu_ctl_w;
wire [2:0] alu_op_w;
wire [3:0] alu_operation_w;
wire [4:0] write_register_w;
wire [4:0] regs_dst_w;
wire [31:0] pc_w;
wire [31:0] instruction_w;
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_w;
wire [31:0] inmmediate_extend_w;
wire [31:0] read_ata_2_r_nmmediate_w;
wire [31:0] alu_result_w;
wire [31:0] pc_plus_4_w;
wire [31:0] read_data_memory_w;
wire [31:0] write_back_w;
wire [31:0] shifted_data_w;
wire [31:0] write_data_reg_file_w;
wire [31:0] sl2_imm_w;
wire [31:0] branch_address_w;
wire [31:0] new_pc_w;
wire [31:0] pc_no_jmp_w;
wire [31:0] jmp_address_w;
wire [31:0] mux_wr_data_or_pc_plus_4_w;





//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	.opcode_i(instruction_w[31:26]),
	.logic_ext_o(logic_ext_w),
	.jal_ctl_o(jal_ctl_w),
	.jmp_ctl_o(jmp_ctl_ctl_w),
	.reg_dst_o(reg_dst_w),
	.branch_ne_o(branch_ne_w),
	.branch_eq_o(branch_eq_w),
	.alu_op_o(alu_op_w),
	.alu_src_o(alu_rc_w),
	.reg_write_o(reg_write_w),
	.mem_read_o(mem_read_w),
	.mem_to_reg_o(mem_to_reg_w),
	.mem_write_o(mem_write_w)
);

Program_Counter
PC
(
	.clk(clk),
	.reset(reset),
	.new_pc_i(new_pc_w),
	.pc_value_o(pc_w)
);



Program_Memory
#
(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROM
(
	.address_i(pc_w),
	.instruction_o(instruction_w)
);



Adder
PC_Puls_4
(
	.data_0_i(pc_w),
	.data_1_i(32'h4),
	
	.result_o(pc_plus_4_w)
);

Data_Memory 
#
(	
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)
)
DATA_MEMORY			//create data memory instance
(
	.clk(clk),
	.mem_read_i(mem_read_w),
	.mem_write_i(mem_write_w),
	.write_data_i(read_data_2_w),
	.address_i(alu_result_w),
	.data_o(read_data_memory_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_READ_DATA_MEM_OR_ALU_RESULT		//4	
(
	.selector_i(mem_to_reg_w),
	.data_0_i(alu_result_w),
	.data_1_i(read_data_memory_w),
	.mux_o(write_back_w)

);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer_2_to_1
#(
	.N_BITS(5)
)
MUX_R_TYPE_OR_I_Type			//0
(
	.selector_i(reg_dst_w),
	.data_0_i(instruction_w[20:16]),
	.data_1_i(instruction_w[15:11]),
	
	.mux_o(regs_dst_w)

);



Register_File
REGISTER_FILE_UNIT
(
	.clk(clk),
	.reset(reset),
	.reg_write_i(reg_write_w),
	.write_register_i(write_register_w),
	.read_register_1_i(instruction_w[25:21]),
	.read_register_2_i(instruction_w[20:16]),
	.write_data_i(mux_wr_data_or_pc_plus_4_w),
	.read_data_1_o(read_data_1_w),
	.read_data_2_o(read_data_2_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_WRITE_DATA_OR_PC_PLUS_4		//1
(
	.selector_i(jal_ctl_w),
	.data_0_i(write_data_reg_file_w),
	.data_1_i(pc_plus_4_w),
	.mux_o(mux_wr_data_or_pc_plus_4_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(5)
)
MUX_RA_OR_REGS			//2
(
	.selector_i(jal_ctl_w),
	.data_0_i(regs_dst_w),
	.data_1_i(5'd31),
	.mux_o(write_register_w)
);

Sign_Extend
SIGNED_EXTEND_FOR_CONSTANTS	
(   
	.logic_ext_i(logic_ext_w),
	.data_i(instruction_w[15:0]),
	.sign_extend_o(inmmediate_extend_w)
);



Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_READ_DATA_2_OR_IMMEDIATE		//3
(
	.selector_i(alu_rc_w),
	.data_0_i(read_data_2_w),
	.data_1_i(inmmediate_extend_w),
	
	.mux_o(read_ata_2_r_nmmediate_w)

);


ALU_Control
ALU_CTRL
(
	.alu_op_i(alu_op_w),
	.alu_function_i(instruction_w[5:0]),
	.alu_operation_o(alu_operation_w),
	.jmp_ctl_o(jmp_ctl_alu_ctl_w)
);



ALU
ALU_UNIT
(
	.alu_operation_i(alu_operation_w),
	.a_i(read_data_1_w),
	.b_i(read_ata_2_r_nmmediate_w),
	.zero_o(zero_w),
	.alu_data_o(alu_result_w)
);


//******************************************************************/
//******************************************************************/
//*********************** MY Modules *******************************/
//******************************************************************/
//******************************************************************/
ShiftLogic
SHIFTLOGIC_UNIT
(
	.sl_opcode_i(instruction_w[31:26]),
	.sl_shamt_i(instruction_w[10:6]),
	.sl_func_i(instruction_w[5:0]),
	.sl_data_i(read_data_2_w),
	.sl_result_o(shifted_data_w),
	.sl_shift_o(shift_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_SHIFTLOGIC_OR_WRITE_BACK		//6
(
	.selector_i(shift_w),
	.data_0_i(write_back_w),
	.data_1_i(shifted_data_w),
	
	.mux_o(write_data_reg_file_w)
);



assign alu_result_o = write_data_reg_file_w;

//******************************************************************/
//******************************************************************/
//*********************** branch control ***************************/
//******************************************************************/
//******************************************************************/

Adder
BRANCH_DIRECTION
(
	.data_0_i(pc_plus_4_w),
	.data_1_i(sl2_imm_w),
	.result_o(branch_address_w)
);

Shift_Left_2 
SHIFT_LEFT_2_EXT_IMMEDIATE
(   
	.data_i(inmmediate_extend_w),
	.data_o(sl2_imm_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
PC_PLUS4_OR_BRANCH			//5
(
	.selector_i(is_branch_w),
	.data_0_i(pc_plus_4_w),
	.data_1_i(branch_address_w),
	.mux_o(pc_no_jmp_w)
);

assign is_branch_w = (branch_ne_w & ~zero_w) | (branch_eq_w & zero_w);


//******************************************************************/
//******************************************************************/
//*********************** jump control *****************************/
//******************************************************************/
//******************************************************************/

Jump_Address 
JMP_ADDRESS
(
	.pc_plus_4_i(pc_plus_4_w),
	.address_i(instruction_w[25:0]),
	.jmp_address_o(jmp_address_w)
);

Multiplexer_3_to_1
#(
	.N_BITS(32)
)
MUX_JMP_CTL
(
	.selector_i(jmp_ctl_w),
	.data_0_i(pc_no_jmp_w),
	.data_1_i(jmp_address_w),
	.data_2_i(read_data_1_w),
	.mux_o(new_pc_w)
);

assign jmp_ctl_w = jmp_ctl_ctl_w | jmp_ctl_alu_ctl_w;

endmodule

