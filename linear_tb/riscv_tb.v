`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 11:11:47
// Design Name: 
// Module Name: riscv_tb
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

module riscv_tb;

    reg clk;
    reg rst_n;

    // Instantiate DUT
    riscv_top dut (
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock Generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // Simulation time
    initial begin
        #90;
        $finish;
    end
    
    
    initial begin
        $display("PC\t\tInstr\t\tOpcode\tRS1\tRS2\tRD\tIMM\t\tALUCtrl\tALU_IN2\t\tALU_OUT");
        $display("---------------------------------------------------------------------------------------------------------------");
    
        $monitor("%h\t%h\t%b\t%2d\t%2d\t%2d\t%h\t%b\t%h\t%h",
                 dut.pc_out,
                 dut.instruction,
                 dut.opcode,
                 dut.rs1,
                 dut.rs2,
                 dut.rd,
                 dut.imm,
                 dut.alu_ctrl,
                 dut.alu_in2,
                 dut.alu_result);
    end
    
endmodule
