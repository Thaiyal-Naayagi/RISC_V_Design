`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 08:49:59
// Design Name: 
// Module Name: riscv_control
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


module riscv_control(opcode, reg_write, alu_src, branch, jump, mem_to_reg,mem_read, mem_write, alu_op);
    input [6:0] opcode;
    output reg [1:0] alu_op;
    output reg reg_write, alu_src, branch, jump, mem_to_reg, mem_write, mem_read;
    
    always@(*) begin
            reg_write= 0;
            alu_src = 0; // take value from register if 0
            branch = 0;
            jump = 0;
            mem_to_reg = 0;
            mem_write = 0;
            alu_op = 0;
            mem_read = 0;
            
            case(opcode)
                7'b0110011: begin // R-type instruction
                            reg_write = 1'b1;
                            alu_op = 2'b10; //look into funct3 and funct7
                        end
                        
                7'b0010011: begin // I-type instruction 
                            reg_write = 1'b1;
                            alu_src = 1'b1; // immediate value
                            alu_op = 2'b11; //look into funct3 only
                        end
                        
                7'b1100011: begin // B-type instruction
                            branch = 1'b1;
                            alu_op = 2'b01; //use subtraction for check only
                        end
                        
                7'b0000011: begin // Load instruction
                            reg_write = 1'b1;
                            alu_src = 1'b1;
                            mem_read = 1'b1; // read from memory
                            mem_to_reg = 1'b1;
                            alu_op = 2'b00; // addition to compute address
                        end
                        
                7'b1101111: begin //  jump unconditional
                            jump = 1'b1;
                            reg_write = 1'b1;
                        end
                        
                7'b0100011: begin //store into memory
                            mem_write = 1'b1;
                            alu_src = 1'b1;
                            alu_op = 2'b00; //addition to compute address
                        end
            endcase
        end
        
endmodule
