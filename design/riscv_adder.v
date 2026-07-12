`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 18:35:38
// Design Name: 
// Module Name: riscv_adder
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


module risc_adder(adder_in1, adder_in2, adder_out);
    input [31:0] adder_in1;
    input [31:0] adder_in2;
    output [31:0] adder_out;
    
    assign adder_out = adder_in1 + adder_in2;
endmodule
