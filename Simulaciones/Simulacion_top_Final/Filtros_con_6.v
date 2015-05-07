`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Filtros_con_6
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
module Filtros_con_6 #(
	parameter p=10,
	parameter f=14,
	parameter Width = p+f+1
)
(
	input wire signed [Width-1:0] uk,
//	input wire clk,
	input wire sclk,rst,
	input wire enable,
	output wire signed [Width-1:0] yk_HPBass,yk_HPMed,yk_HPHigh
);

wire signed [Width-1:0] uk_LPBass,uk_LPMed,uk_LPHigh;


Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(0),
	.pb1(0),
	.pb2(0),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) LPBass(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPBass),
	.a1(16'h7d71), // 01.11 1101 0111 0001         1.96
	.a2(15'hc287),//  1.00 0010 1000 0111		-0.9605
	.b0(15'h0003), // 0.00 0000 0000 0011 	0.000199
	.b1(15'h0007), // 0.00 0000 0000 0111 0.0003979
	.b2(15'h0003) //  0.00 0000 0000 0011 0.000199
	); 

Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(0),
	.pb1(1),
	.pb2(0),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) HPBass(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPBass),
	.yk(yk_HPBass),
	.a1(16'h7fbe), // 01.11 1111 1011 1110  1.996
	.a2(15'hc042), // 1.00 0000 0100 0010 -0.996
	.b0(15'h3fdf), // 0.11 1111 1101 1111 0.998
	.b1(16'h8042), // 10.00 0000 0100 0010  -1.996
	.b2(15'h3fdf) // 0.11 1111 1101 1111  0.998
	);
 
Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(0),
	.pb1(0),
	.pb2(0),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) LPMed(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPMed),
	.a1(16'h423d), //1.035
	.a2(15'he876), //-0.3678
	.b0(15'h0552), //0.08316
	.b1(15'h0110), //0.1663
	.b2(15'h0552)  //0.08316
	); 

Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(1),
	.pb1(1),
	.pb2(1),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) HPMed(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPMed),
	.yk(yk_HPMed),
	.a1(16'h7d71), //1.96
	.a2(15'hc287), //-0.9605
	.b0(16'h4000), //1
	.b1(16'h8000), //-2
	.b2(16'h4000)  //1
	); 

Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(0),
	.pb1(1),
	.pb2(0),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) LPHigh(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPHigh),
	.a1(16'h9a2d), //-1.591  	10.01 1010 0010 1101
	.a2(15'hd5a7), //-0.6617 	1.01 0101 1010 0111
	.b0(15'h340b), //0.8132 	0.11 0100 0000 1011
	.b1(16'h6810), //1.626 		01.10 1000 0001 0000
	.b2(15'h340b)  //0.8132 	0.11 0100 0000 1011
	); 

Filtro #(
	.p(p),
	.f(f),
	.pa1(1),
	.pa2(0),
	.pb0(0),
	.pb1(1),
	.pb2(0),
	.fa1(14),
	.fa2(14),
 	.fb0(14),
	.fb1(14),
	.fb2(14)
) HPHigh(
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPHigh),
	.yk(yk_HPHigh),
	.a1(16'h423d), //1.035 		01.00 0010 0011 1101
	.a2(15'he876), //-0.3678 	11.10 1000 0111 0110
	.b0(15'h2672), //0.6007 	0.10 0110 0111 0010
	.b1(16'hb323), //-1.201 	10.11 0011 0010 0011
	.b2(15'h2672)  //0.6007 	0.10 0110 0111 0010
	); 

endmodule

