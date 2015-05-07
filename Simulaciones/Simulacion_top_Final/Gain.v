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
	input wire [1:0] gain_set,
	output wire [Width-1:0] ykgain
);

Mult #(.f_A(f),.p_A(p),.f_B(1),.p_B(1)) mult_gain(
    .A(yk), 
    .B({1'b0,gain_set}), 
    .Y(ykgain)
    );

endmodule
