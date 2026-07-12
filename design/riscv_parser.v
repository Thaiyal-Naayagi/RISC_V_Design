`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2026 09:25:07
// Design Name: 
// Module Name: riscv_parser
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


module riscv_parser(instruction, rd, funct3, rs1, rs2, funct7, opcode);
    input [31:0] instruction;
    output [4:0] rs1, rs2, rd;
    output [2:0] funct3;
    output [6:0] funct7;
    output [6:0] opcode;
    
    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct7 = instruction[31:25];
    
endmodule
