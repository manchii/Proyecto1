`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Gain
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Gain#(
	parameter p=4,
	parameter f=13,
	parameter Width = 1+p+f
)
( 
	input wire [Width-1:0] yk,
	input wire [Width-1:0] gain_set,
	output wire [Width-1:0] ykgain
);

Mult #(.f(f),.p(p)) mult_fk1a1(
    .A(yk), 
    .B(gain_set), 
    .Y(ykgain)
    );

endmodule
