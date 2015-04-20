`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Cod_bin_hex
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//17
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Cod_bin_hex(
	input wire [3:0] i, 
	output reg [6:0] o
);

   always @(i)
      case (i)
          4'b0001 : o = 7'b1111001;   // 1
          4'b0010 : o = 7'b0100100;   // 2
          4'b0011 : o = 7'b0110000;   // 3
          4'b0100 : o = 7'b0011001;   // 4
          4'b0101 : o = 7'b0010010;   // 5
          4'b0110 : o = 7'b0000010;   // 6
          4'b0111 : o = 7'b1111000;   // 7
          4'b1000 : o = 7'b0000000;   // 8
          4'b1001 : o = 7'b0010000;   // 9
          4'b1010 : o = 7'b0001000;   // A
          4'b1011 : o = 7'b0000011;   // b
          4'b1100 : o = 7'b1000110;   // C
          4'b1101 : o = 7'b0100001;   // d
          4'b1110 : o = 7'b0000110;   // E
          4'b1111 : o = 7'b0001110;   // F
          default : o = 7'b1000000;   // 0
      endcase
endmodule
