`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 13:11:15
// Design Name: 
// Module Name: riscv_mem
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


module riscv_mem(clk, mem_write, mem_read, write_addr, write_data, read_data);
    input clk, mem_write, mem_read;
    input [31:0] write_addr, write_data;
    output reg [31:0] read_data;
    reg [7:0] mem [0:4095];
    
    always @(posedge clk) begin
        if(mem_write) begin
            mem[write_addr] = write_data[7:0];
            mem[write_addr+1] = write_data[15:8];
            mem[write_addr+2] = write_data[23:16];
            mem[write_addr+3] = write_data[31:24];
        end
    end
    
    always @(*) begin
        if(mem_read) begin
            read_data = {mem[write_addr+3],mem[write_addr+2],mem[write_addr+1],mem[write_addr]};
        end
        else read_data = 32'b0;
    end
     
endmodule
