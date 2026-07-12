`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 08:24:41
// Design Name: 
// Module Name: riscv_alu_control
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


module riscv_alu_control(alu_op, funct3, funct7, alu_ctrl);
    input [1:0] alu_op;
    input [2:0] funct3;
    input [6:0] funct7;
    output reg [3:0] alu_ctrl;
    
    always @(*) begin
        case(alu_op)
            2'b00: alu_ctrl = 4'b0000; // add to compute address for load and store
            2'b01: alu_ctrl = 4'b0001; // sub to compare in b-type
            
            2'b10: begin
                case({funct7, funct3})
                    //arithmetic
                    10'b0000000_000: alu_ctrl = 4'b0000; //add
                    10'b0100000_000: alu_ctrl = 4'b0001; //sub
                    10'b0000001_000: alu_ctrl = 4'b1010; // mul
                    
                    //shift
                    10'b0000000_001: alu_ctrl = 4'b0101; // SLL
                    10'b0000000_101: alu_ctrl = 4'b0110; // SRL
                    10'b0100000_101: alu_ctrl = 4'b0111; // SRA
                    
                    // Comparison
                    10'b0000000_010: alu_ctrl = 4'b1000; // SLT
                    10'b0000000_011: alu_ctrl = 4'b1001; // SLTU
                    
                    // Logic
                    10'b0000000_100: alu_ctrl = 4'b0100; // XOR
                    10'b0000000_110: alu_ctrl = 4'b0011; // OR
                    10'b0000000_111: alu_ctrl = 4'b0010; // AND
                    
                     // Division
                     10'b0000001_100: alu_ctrl = 4'b1011; // DIV
                     
                     default: alu_ctrl = 4'b0000;
                endcase
            end
            
            2'b11: begin
                case(funct3)
                    3'b000: alu_ctrl = 4'b0000; //add
                    3'b001: alu_ctrl = 4'b0101; // SLLI
                    3'b010: alu_ctrl = 4'b1000; // SLTI set less than
                    3'b011: alu_ctrl = 4'b1001; // SLTIU set less than unsigned
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    
                    3'b101: begin
                        if(funct7 == 7'b0000000)
                            alu_ctrl = 4'b0110; // SRLI
                        else if(funct7 == 7'b0100000)
                            alu_ctrl = 4'b0111; // SRAI
                        else
                            alu_ctrl = 4'b0000;
                    end
                    
                    3'b110: alu_ctrl = 4'b0011; // ORI
                    3'b111: alu_ctrl = 4'b0010; // ANDI
                    default: alu_ctrl = 4'b0000;
                endcase
            end
            
            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule
