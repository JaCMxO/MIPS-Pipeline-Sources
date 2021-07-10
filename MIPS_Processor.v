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

wire pc_write_w;
wire IFID_write_w;
wire ctl_flush_w;
wire reg_dst_w;
wire alu_src_w;
wire reg_write_w;
wire reg_write_Pipe_MEMWB_w;
wire zero_w;
wire zero_Pipe_EXMEM_w;
wire mem_to_reg_w;
wire mem_to_reg_Pipe_MEMWB_w;
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
wire [1:0] forward_A_w;
wire [1:0] forward_B_w;
wire [2:0] alu_op_w;
wire [3:0] alu_operation_w;
wire [4:0] write_register_w;
wire [4:0] write_register_Pipe_EXMEM_w;
wire [4:0] write_register_Pipe_MEMWB_w;
wire [4:0] regs_dst_w;
wire [5:0] control_out_Pipe_EXMEM_w;
wire [14:0] control_out_w;
wire [14:0] mux_ctl_flush_w;
wire [14:0] control_out_Pipe_IDEX_w;
wire [31:0] instruction_Pipe_IDEX_w;
wire [31:0] pc_w;
wire [31:0] instruction_w;
wire [31:0] instruction_Pipe_IFID_w;
wire [31:0] read_data_1_Pipe_IDEX_w;
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_Pipe_IDEX_w;
wire [31:0]	read_data_2_Pipe_EXMEM_w;
wire [31:0] read_data_2_w;
wire [31:0] inmmediate_extend_Pipe_IDEX_w;
wire [31:0] inmmediate_extend_w;
wire [31:0] read_data_2_r_immediate_w;
wire [31:0] alu_result_w;
wire [31:0] alu_result_Pipe_EXMEM_w;
wire [31:0] alu_result_Pipe_MEMWB_w;
wire [31:0] pc_plus_4_Pipe_IDEX_w;
wire [31:0] pc_plus_4_Pipe_IFID_w;
wire [31:0] pc_plus_4_w;
wire [31:0] read_data_memory_w;
wire [31:0] read_data_memory_Pipe_MEMWB_w;
wire [31:0] write_back_w;
wire [31:0] shifted_data_w;
wire [31:0] sl2_imm_w;
wire [31:0] branch_address_w;
wire [31:0] branch_address_Pipe_EXMEM_w;
wire [31:0] new_pc_w;
wire [31:0] pc_no_jmp_w;
wire [31:0] jmp_address_w;
wire [31:0] mux_wr_data_or_pc_plus_4_Pipe_IDEX_w;
wire [31:0] alu_input_A_w;
wire [31:0] mux_alu_src_forwarding_B_w;
wire [31:0] ex_data_out_w;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	.opcode_i(instruction_Pipe_IFID_w[31:26]),
	.logic_ext_o(logic_ext_w),
	.jal_ctl_o(jal_ctl_w),
	.jmp_ctl_o(jmp_ctl_ctl_w),
	.reg_dst_o(reg_dst_w),
	.branch_ne_o(branch_ne_w),
	.branch_eq_o(branch_eq_w),
	.alu_op_o(alu_op_w),
	.alu_src_o(alu_src_w),
	.reg_write_o(reg_write_w),
	.mem_read_o(mem_read_w),
	.mem_to_reg_o(mem_to_reg_w),
	.mem_write_o(mem_write_w)
);

/*
bit
14		logic_ext_w
13		jal_ctl_w
12-11	jmp_ctl_ctl_w
10		reg_dst_w
9		alu_src_w
8		mem_to_reg_w
7		reg_write_w
6		mem_read_w
5		mem_write_w
4		branch_ne_w
3		branch_eq_w
2-1		alu_op_w
*/
assign control_out_w = {
	logic_ext_w,
	jal_ctl_w,
	jmp_ctl_ctl_w,
	reg_dst_w,
	alu_src_w,
	mem_to_reg_w,
	reg_write_w,
	mem_read_w,
	mem_write_w,
	branch_ne_w,
	branch_eq_w,
	alu_op_w
};

Program_Counter
PC
(
	.clk(clk),
	.reset(reset),
	.enable(pc_write_w),
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
	.mem_read_i(control_out_Pipe_EXMEM_w[3]),
	.mem_write_i(control_out_Pipe_EXMEM_w[2]),
	.write_data_i(read_data_2_Pipe_EXMEM_w),
	.address_i(alu_result_Pipe_EXMEM_w),
	.data_o(read_data_memory_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_READ_DATA_MEM_OR_ALU_RESULT		//4	
(
	.selector_i(mem_to_reg_Pipe_MEMWB_w),
	.data_0_i(alu_result_Pipe_MEMWB_w),
	.data_1_i(read_data_memory_Pipe_MEMWB_w),
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
	.selector_i(control_out_Pipe_IDEX_w[10]),
	.data_0_i(instruction_Pipe_IDEX_w[20:16]),
	.data_1_i(instruction_Pipe_IDEX_w[15:11]),
	
	.mux_o(regs_dst_w)

);

Register_File
REGISTER_FILE_UNIT
(
	.clk(clk),
	.reset(reset),
	.reg_write_i(reg_write_Pipe_MEMWB_w),
	.write_register_i(write_register_Pipe_MEMWB_w),
	.read_register_1_i(instruction_Pipe_IFID_w[25:21]),
	.read_register_2_i(instruction_Pipe_IFID_w[20:16]),
	.write_data_i(mux_wr_data_or_pc_plus_4_Pipe_IDEX_w),
	.read_data_1_o(read_data_1_w),
	.read_data_2_o(read_data_2_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_WRITE_DATA_OR_PC_PLUS_4		//1
(
	.selector_i(control_out_Pipe_IDEX_w[13]),
	.data_0_i(write_back_w),
	.data_1_i(pc_plus_4_Pipe_IDEX_w),
	.mux_o(mux_wr_data_or_pc_plus_4_Pipe_IDEX_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(5)
)
MUX_RA_OR_REGS			//2
(
	.selector_i(control_out_Pipe_IDEX_w[13]),
	.data_0_i(regs_dst_w),
	.data_1_i(5'd31),
	.mux_o(write_register_w)
);

Sign_Extend
SIGNED_EXTEND_FOR_CONSTANTS	
(   
	.logic_ext_i(logic_ext_w),
	.data_i(instruction_Pipe_IFID_w[15:0]),
	.sign_extend_o(inmmediate_extend_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_READ_DATA_2_OR_IMMEDIATE		//3
(
	.selector_i(control_out_Pipe_IDEX_w[9]),
	.data_0_i(mux_alu_src_forwarding_B_w),
	.data_1_i(inmmediate_extend_Pipe_IDEX_w),
	
	.mux_o(read_data_2_r_immediate_w)

);

ALU_Control
ALU_CTRL
(
	.alu_op_i(control_out_Pipe_IDEX_w[2:0]),
	.alu_function_i(instruction_Pipe_IDEX_w[5:0]),
	.alu_operation_o(alu_operation_w),
	.jmp_ctl_o(jmp_ctl_alu_ctl_w)
);

ALU
ALU_UNIT
(
	.alu_operation_i(alu_operation_w),
	.a_i(alu_input_A_w),
	.b_i(read_data_2_r_immediate_w),
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
	.sl_opcode_i(instruction_Pipe_IDEX_w[31:26]),
	.sl_shamt_i(instruction_Pipe_IDEX_w[10:6]),
	.sl_func_i(instruction_Pipe_IDEX_w[5:0]),
	.sl_data_i(mux_alu_src_forwarding_B_w),
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
	.data_0_i(alu_result_w),
	.data_1_i(shifted_data_w),
	
	.mux_o(ex_data_out_w)
);

assign alu_result_o = mux_wr_data_or_pc_plus_4_Pipe_IDEX_w;

//******************************************************************/
//******************************************************************/
//*********************** branch control ***************************/
//******************************************************************/
//******************************************************************/

Adder
BRANCH_DIRECTION
(
	.data_0_i(pc_plus_4_Pipe_IDEX_w),
	.data_1_i(sl2_imm_w),
	.result_o(branch_address_w)
);

Shift_Left_2 
SHIFT_LEFT_2_EXT_IMMEDIATE
(   
	.data_i(inmmediate_extend_Pipe_IDEX_w),
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
	.data_1_i(branch_address_Pipe_EXMEM_w),
	.mux_o(pc_no_jmp_w)
);

assign is_branch_w = (control_out_Pipe_EXMEM_w[1] & ~zero_Pipe_EXMEM_w) | 
					(control_out_Pipe_EXMEM_w[0] & zero_Pipe_EXMEM_w);

//******************************************************************/
//******************************************************************/
//*********************** jump control *****************************/
//******************************************************************/
//******************************************************************/

Jump_Address 
JMP_ADDRESS
(
	.pc_plus_4_i(pc_plus_4_w),
	.address_i(instruction_Pipe_IDEX_w[25:0]),
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
	.data_2_i(read_data_1_Pipe_IDEX_w),
	.mux_o(new_pc_w)
);

assign jmp_ctl_w = control_out_Pipe_IDEX_w[12:11] | jmp_ctl_alu_ctl_w;

//******************************************************************/
//******************************************************************/
//*********************** Pipeline registers ***********************/
//******************************************************************/
//******************************************************************/

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IFID_PROGRAM_MEM
(
	.clk(clk),
	.reset(reset),
	.enable(IFID_write_w),
	.data_i(instruction_w),
	.data_o(instruction_Pipe_IFID_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IFID_PC_PLUS_4
(
	.clk(clk),
	.reset(reset),
	.enable(IFID_write_w),
	.data_i(pc_plus_4_w),
	.data_o(pc_plus_4_Pipe_IFID_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IDEX_PC_PLUS_4
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(pc_plus_4_Pipe_IFID_w),
	.data_o(pc_plus_4_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IDEX_SIGN_EXTEND
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(inmmediate_extend_w),
	.data_o(inmmediate_extend_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IDEX_INSTRUCTION
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(instruction_Pipe_IFID_w),
	.data_o(instruction_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IDEX_READ_DATA_1
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(read_data_1_w),
	.data_o(read_data_1_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_IDEX_READ_DATA_2
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(read_data_2_w),
	.data_o(read_data_2_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(15)
)
PIPER_IDEX_CONTROL
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(mux_ctl_flush_w),
	.data_o(control_out_Pipe_IDEX_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_EXMEM_ALU_RESULT
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(ex_data_out_w),
	.data_o(alu_result_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(1)
)
PIPER_EXMEM_ALU_ZERO
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(zero_w),
	.data_o(zero_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_EXMEM_WRITE_DATA
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(mux_alu_src_forwarding_B_w),
	.data_o(read_data_2_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_EXMEM_BRANCH_ADDRESS
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(branch_address_w),
	.data_o(branch_address_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(5)
)
PIPER_EXMEM_WRITE_REGISTER
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(write_register_w),
	.data_o(write_register_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(6)
)
PIPER_EXMEM_CONTROL
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(
		{
			control_out_Pipe_IDEX_w[8],		//mem_to_reg [5]
			control_out_Pipe_IDEX_w[7],		//reg_write [4]
			control_out_Pipe_IDEX_w[6],		//mem_read [3]
			control_out_Pipe_IDEX_w[5],		//mem_write [2]
			control_out_Pipe_IDEX_w[4],		//branch_ne [1]
			control_out_Pipe_IDEX_w[3]		//branch_eq [0]
		}
	),
	.data_o(control_out_Pipe_EXMEM_w)
);

Register_Pipeline
#(
	.N_BITS(1)
)
PIPER_MEMWB_MEM_TO_REG
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(control_out_Pipe_EXMEM_w[5]),
	.data_o(mem_to_reg_Pipe_MEMWB_w)
);

Register_Pipeline
#(
	.N_BITS(1)
)
PIPER_MEMWB_REG_WRITE
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(control_out_Pipe_EXMEM_w[4]),
	.data_o(reg_write_Pipe_MEMWB_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_MEMWB_READ_DATA
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(read_data_memory_w),
	.data_o(read_data_memory_Pipe_MEMWB_w)
);

Register_Pipeline
#(
	.N_BITS(32)
)
PIPER_MEMWB_ALU_RESULT
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(alu_result_Pipe_EXMEM_w),
	.data_o(alu_result_Pipe_MEMWB_w)
);

Register_Pipeline
#(
	.N_BITS(5)
)
PIPER_MEMWB_WRITE_REGISTER
(
	.clk(clk),
	.reset(reset),
	.enable(1'b1),
	.data_i(write_register_Pipe_EXMEM_w),
	.data_o(write_register_Pipe_MEMWB_w)
);


//******************************************************************/
//******************************************************************/
//**************** Forwarding unit implementation ******************/
//******************************************************************/
//******************************************************************/
Forwarding_Control
FORWARDING_CONTROL_UNIT
(
	.ctl_reg_write_EXMEM_i(control_out_Pipe_EXMEM_w[4]),
	.ctl_reg_write_MEMWB_i(reg_write_Pipe_MEMWB_w),
	.reg_rs_IDEX_i(instruction_Pipe_IDEX_w[25:21]),
	.reg_rt_IDEX_i(instruction_Pipe_IDEX_w[20:16]),
	.reg_dest_EXMEM_i(write_register_Pipe_EXMEM_w),
	.reg_dest_MEMWB_i(write_register_Pipe_MEMWB_w),
	.forward_A_o(forward_A_w),
	.forward_B_o(forward_B_w)
);

Multiplexer_3_to_1
#(
	.N_BITS(32)
)
MUX_ALU_SRC_A
(
	.selector_i(forward_A_w),
	.data_0_i(read_data_1_Pipe_IDEX_w),
	.data_1_i(mux_wr_data_or_pc_plus_4_Pipe_IDEX_w),
	.data_2_i(alu_result_Pipe_EXMEM_w),
	.mux_o(alu_input_A_w)
);

Multiplexer_3_to_1
#(
	.N_BITS(32)
)
MUX_ALU_SRC_B
(
	.selector_i(forward_B_w),
	.data_0_i(read_data_2_Pipe_IDEX_w),
	.data_1_i(mux_wr_data_or_pc_plus_4_Pipe_IDEX_w),
	.data_2_i(alu_result_Pipe_EXMEM_w),
	.mux_o(mux_alu_src_forwarding_B_w)
);

//******************************************************************/
//******************************************************************/
//**************** Hazard Detection implementation *****************/
//******************************************************************/
//******************************************************************/

Hazard_Detection 
HAZARD_DETECTION_UNIT
(
	.ctl_mem_read_IDEX_i(control_out_Pipe_IDEX_w[6]),
	.reg_rt_IDEX_i(instruction_Pipe_IDEX_w[20:16]),
	.reg_rs_IFID_i(instruction_Pipe_IFID_w[25:21]),
	.reg_rt_IFID_i(instruction_Pipe_IFID_w[20:16]),
	.PC_write_o(pc_write_w),
	.IFID_write_o(IFID_write_w),
	.ctl_flush_o(ctl_flush_w)
);

Multiplexer_2_to_1
#(
	.N_BITS(15)
)
MUX_CONTROL_FLUSH
(
	.selector_i(ctl_flush_w),
	.data_0_i({15{1'b0}}),
	.data_1_i(control_out_w),
	.mux_o(mux_ctl_flush_w)
);

endmodule

