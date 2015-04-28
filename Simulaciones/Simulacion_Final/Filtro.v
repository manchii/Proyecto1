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
	parameter Width = 1+p+f
)
(
	input wire sclk, rst,enable,
	input wire signed [Width-1:0] uk,
	input wire signed [Width-1:0] a1, a2, b0, b1, b2,
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
    .A(uk), 
    .B(sum_fk1a1_fk2a2), 
    .Y(fk)
    );

Sum #(.Width(Width)) Sum_fk1a1_fk2a2(
    .A(fk1a1), 
    .B(fk2a2), 
    .Y(sum_fk1a1_fk2a2)
    );

Sum #(.Width(Width)) Sum_yk(
    .A(fkb0), 
    .B(sum_fk1b1_fk2b2), 
    .Y(yk)
    );

Sum #(.Width(Width)) Sum_fk1b1_fk2b2(
    .A(fk1b1), 
    .B(fk2b2), 
    .Y(sum_fk1b1_fk2b2)
    );


//Multiplicación

Mult #(.f(f),.p(p)) mult_fk1a1(
    .A(a1), 
    .B(fk1), 
    .Y(fk1a1)
    );

Mult #(.f(f),.p(p)) mult_fk2a2 (
    .A(a2), 
    .B(fk2), 
    .Y(fk2a2)
    );

Mult #(.f(f),.p(p)) mult_fkb0 (
    .A(b0), 
    .B(fk), 
    .Y(fkb0)
    );

Mult #(.f(f),.p(p)) mult_fk1b1 (
    .A(b1), 
    .B(fk1), 
    .Y(fk1b1)
    );

Mult  #(.f(f),.p(p)) mult_fk2b2 (
    .A(b2), 
    .B(fk2), 
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
