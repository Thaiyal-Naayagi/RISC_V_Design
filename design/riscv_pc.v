`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 18:28:57
// Design Name: 
// Module Name: riscv_pc
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


module riscv_pc(clk,rst_n,pc_in,pc_out);
    input clk, rst_n;
    input [31:0] pc_in;
    output reg [31:0] pc_out;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) pc_out <= 31'b0;
        else begin
            pc_out <= pc_in;
        end
    end
    
endmodule
