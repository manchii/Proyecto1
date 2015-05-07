`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Filtro
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
module Filtro#(
	parameter p=8,
	parameter f=14,
	parameter pa1=8,
	parameter pa2=8,
	parameter pb0=8,
	parameter pb1=8,
	parameter pb2=8,
	parameter fa1=14,
	parameter fa2=14,
	parameter fb0=14,
	parameter fb1=14,
	parameter fb2=14,
	parameter Width = 1+p+f
)
(
//	input wire clk, 
	input wire sclk, rst,enable,
	input wire signed [Width-1:0] uk,
	input wire signed [pa1+fa1:0] a1, 
	input wire signed [pa2+fa2:0] a2, 
	input wire signed [pb0+fb0:0] b0, 
	input wire signed [pb1+fb1:0] b1, 
	input wire signed [pb2+fb2:0] b2,
	output wire signed [Width-1:0] yk
);

wire signed [Width-1:0] fk1,fk2;
wire signed [Width-1:0] fk,fkb0;
wire signed [Width-1:0] fk1a1,fk2a2;
wire signed [Width-1:0] fk1b1,fk2b2;
wire signed [Width-1:0] sum_fk1a1_fk2a2;
wire signed [Width-1:0] sum_fk1b1_fk2b2;


//Sumas

Sum #(.Width(Width)) Sum_fk(
//	 .clk(clk),
//	 .rst(rst),
    .A(uk), 
    .B(sum_fk1a1_fk2a2), 
    .Y(fk)
    );

Sum #(.Width(Width)) Sum_fk1a1_fk2a2(
//	 .clk(clk),
//	 .rst(rst),
    .A(fk1a1), 
    .B(fk2a2), 
    .Y(sum_fk1a1_fk2a2)
    );

Sum #(.Width(Width)) Sum_yk(
//	 .clk(clk),
//	 .rst(rst),
    .A(fkb0), 
    .B(sum_fk1b1_fk2b2), 
    .Y(yk)
    );

Sum #(.Width(Width)) Sum_fk1b1_fk2b2(
//	 .clk(clk),
//	 .rst(rst),
    .A(fk1b1), 
    .B(fk2b2), 
    .Y(sum_fk1b1_fk2b2)
    );


//Multiplicación

Mult #(.f_A(f),.p_A(p),.f_B(fa1),.p_B(pa1)) mult_fk1a1(
    .A(fk1), 
    .B(a1), 
    .Y(fk1a1)
    );

Mult #(.f_A(f),.p_A(p),.f_B(fa2),.p_B(pa2)) mult_fk2a2 (
    .A(fk2), 
    .B(a2), 
    .Y(fk2a2)
    );

Mult #(.f_A(f),.p_A(p),.f_B(fb0),.p_B(pb0)) mult_fkb0 (
    .A(fk), 
    .B(b0), 
    .Y(fkb0)
    );

Mult #(.f_A(f),.p_A(p),.f_B(fb1),.p_B(pb1)) mult_fk1b1 (
    .A(fk1), 
    .B(b1), 
    .Y(fk1b1)
    );

Mult  #(.f_A(f),.p_A(p),.f_B(fb2),.p_B(pb2)) mult_fk2b2 (
    .A(fk2), 
    .B(b2), 
    .Y(fk2b2)
    );

//Registros

Reg #(.Width(Width)) reg_fk1 (
	.A(fk),
	.Y(fk1),
	.clk(sclk),
	.rst(rst),
	.enable(enable)
	);

Reg #(.Width(Width)) reg_fk2(
	.A(fk1),
	.Y(fk2),
	.clk(sclk),
	.rst(rst),
	.enable(enable)
	);


endmodule
