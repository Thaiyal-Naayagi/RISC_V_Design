`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 13:44:39
// Design Name: 
// Module Name: riscv_alu
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


module riscv_alu(in0, in1, alu_ctrl, out, zero);
    input [31:0] in0, in1;
    input [3:0] alu_ctrl;
    output reg [31:0] out;
    output zero;
    
    always @(*) begin
        case(alu_ctrl) 
            4'b0: out = in0 + in1;
            4'b1: out = in0 - in1;
            4'b10: out = in0 & in1;
            4'b11: out = in0 | in1;
            4'b100: out = in0 ^ in1;
            4'b101: out = in0 << in1[4:0];
            4'b110: out = in0 >> in1[4:0];
            4'b111: out = $signed(in0) >>> in1[4:0];
            4'b1000: out = ($signed(in0) < $signed(in1)) ? 32'd1 : 32'd0;
            4'b1001: out = (in0 < in1) ? 32'd1 : 32'd0;
            4'b1010: out = in0 * in1;
            4'b1011: out = (in1 != 0) ? (in0 / in1) : 32'b0;
            default: out = 32'd0;
        endcase
    end 
    
    assign zero = (out == 32'b0);
endmodule
