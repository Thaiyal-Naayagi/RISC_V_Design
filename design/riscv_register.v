`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2026 10:30:22
// Design Name: 
// Module Name: riscv_register
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


module riscv_register(clk, reg_write, rs1_addr, rs2_addr, wr_data, rd_addr, rs1_data, rs2_data);
    input clk, reg_write;
    input [4:0] rs1_addr, rs2_addr, rd_addr;
    input [31:0] wr_data;
    output [31:0] rs1_data, rs2_data;
    
    reg [31:0] gpr [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1)
            gpr[i] = 32'd0;
    end
    
    always @(posedge clk) begin
        if(reg_write) begin
            gpr[rd_addr] <= wr_data;
        end
    end
    
    assign rs1_data = (rs1_addr == 0) ? 32'b0 : gpr[rs1_addr]; //architectural rule that x0 must always return 0
    assign rs2_data = (rs2_addr == 0) ? 32'b0 : gpr[rs2_addr];
endmodule
