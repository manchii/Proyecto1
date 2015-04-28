`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Filtro_Banda
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

module Filtro_Banda #(
	parameter p=13,
	parameter f=18,
	parameter Width = p+f+1
)
(
	input wire signed [Width-1:0] uk,
	input wire clk,rst,
	input wire enable,
	input wire signed [Width-1:0] La1,La2,Lb0,Lb1,Lb2,
	input wire signed [Width-1:0] Ha1,Ha2,Hb0,Hb1,Hb2,
	output wire signed [Width-1:0] yk
);

wire signed [Width-1:0] ykL;

Filtro #(.p(p),.f(f)) FiltroL(
	.sclk(clk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(ykL),
	.a1(La1), 
	.a2(La2), 
	.b0(Lb0), 
	.b1(Lb1), 
	.b2(Lb2) 
	); 

Filtro #(.p(p),.f(f)) FiltroH(
	.sclk(clk),
	.rst(rst),
	.enable(enable),
	.uk(ykL),
	.yk(yk),
	.a1(Ha1), 
	.a2(Ha2), 
	.b0(Hb0), 
	.b1(Hb1), 
	.b2(Hb2)  
	);


endmodule
