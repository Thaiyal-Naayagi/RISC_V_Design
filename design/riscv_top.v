`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 10:02:42
// Design Name: 
// Module Name: riscv_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riscv_top(clk, rst_n);
    input clk, rst_n;
    
    //program counter
    wire [31:0] pc_out;
    wire [31:0] pc_in;
    wire [31:0] pc_plus4;
    wire [31:0] branch_addr;
    
    // Instruction
    wire [31:0] instruction;
    
    // Parser outputs
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;
    
    // Immediate
    wire [31:0] imm;
    
    // Control Signals
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_src;
    wire branch;
    wire jump;
    wire [1:0] alu_op;

    // Register File
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] write_data;
    
    // ALU
    wire [31:0] alu_in2;
    wire [31:0] alu_result;
    wire zero;
    wire [3:0] alu_ctrl;

    // Data Memory
    wire [31:0] mem_read_data;
    
    wire pc_src;
    wire branch_taken;
    
    assign branch_taken = (funct3 == 3'b000) ? zero : (funct3 == 3'b001) ? ~zero : 0;
    assign pc_src = jump | (branch & branch_taken);
    
    riscv_pc pc(.clk(clk),.rst_n(rst_n),.pc_in(pc_in),.pc_out(pc_out));
    riscv_instr_mem instr_mem(.instr_in(pc_out), .instr_out(instruction));
    riscv_parser parser(.instruction(instruction), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7), .opcode(opcode));
    riscv_imm_generator imm_gen(.instr(instruction), .imm(imm));
    riscv_control control_unit(.opcode(opcode), .reg_write(reg_write), .alu_src(alu_src), .branch(branch), .jump(jump), .mem_to_reg(mem_to_reg), .mem_read(mem_read), .mem_write(mem_write), .alu_op(alu_op));
    riscv_register reg_block(.clk(clk), .reg_write(reg_write), .rs1_addr(rs1), .rs2_addr(rs2), .wr_data(write_data), .rd_addr(rd), .rs1_data(read_data1), .rs2_data(read_data2));
    riscv_alu_control alu_control(.alu_op(alu_op), .funct3(funct3), .funct7(funct7), .alu_ctrl(alu_ctrl));
    risc_mux src_mux(.in0(read_data2), .in1(imm), .in2(0), .in3(0), .sel({0,alu_src}), .out(alu_in2));
    riscv_alu alu(.in0(read_data1), .in1(alu_in2), .alu_ctrl(alu_ctrl), .out(alu_result), .zero(zero));
    riscv_mem data_mem(.clk(clk), .mem_write(mem_write), .mem_read(mem_read), .write_addr(alu_result), .write_data(read_data2), .read_data(mem_read_data));
    risc_mux wb_mux(.in0(alu_result), .in1(mem_read_data), .in2(0), .in3(0), .sel({0,mem_to_reg}), .out(write_data));
    risc_adder pc4_adder(.adder_in1(pc_out), .adder_in2(32'd4), .adder_out(pc_plus4));
    risc_adder pcbr_adder(.adder_in1(pc_out), .adder_in2(imm), .adder_out(branch_addr));
    risc_mux pc_mux(.in0(pc_plus4), .in1(branch_addr), .in2(0), .in3(0), .sel({0,pc_src}), .out(pc_in));
endmodule
