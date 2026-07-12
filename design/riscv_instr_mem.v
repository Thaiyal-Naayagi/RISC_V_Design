`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2026 08:12:15
// Design Name: 
// Module Name: riscv_instr_mem
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


module riscv_instr_mem(instr_in, instr_out);
    input [31:0] instr_in;
    output [31:0] instr_out;
    
    reg [31:0] instr_mem [0:63];
    
    initial begin
        $readmemh("instr_mem.mem",instr_mem);
    end
    
    assign  instr_out = instr_mem[instr_in[31:2]]; //to divide by 4 as in risc 32-bit each of instruction consume 4-bytes of memory
    
endmodule
