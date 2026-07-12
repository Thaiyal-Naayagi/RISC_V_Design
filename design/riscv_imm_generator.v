`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 09:31:12
// Design Name: 
// Module Name: riscv_imm_generator
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


module riscv_imm_generator(instr, imm);
    input [31:0] instr;
    output reg [31:0] imm;
    
    wire [6:0] opcode;
    assign opcode = instr[6:0];
    
    always @(*) begin // here sign extension is considered - to avoid sign from being changed the msb is repeated until 32-bits are generated
        case(opcode) 
            7'b0010011: imm = {{20{instr[31]}}, instr[31:20]}; //I-type
            7'b0100011: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; //store
            7'b1100011: imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; //b-type
            7'b1101111: imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; //j-type

            default: imm = 32'b0;   
        endcase
    end
endmodule
