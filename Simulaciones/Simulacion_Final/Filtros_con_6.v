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
	parameter p=8,
	parameter f=14,
	parameter Width = p+f+1
)
(
	input wire signed [Width-1:0] uk,
	input wire sclk,rst,
	input wire enable,
	output wire signed [Width-1:0] yk_HPBass,yk_HPMed,yk_HPHigh
);

wire signed [Width-1:0] uk_LPBass,uk_LPMed,uk_LPHigh;


Filtro #(
	.p(p),
	.f(f)
) LPBass(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPBass),
	.a1(23'h007d71), //1.96
	.a2(23'h7fc287), //-0.9605
	.b0(23'h000003), //0.000199
	.b1(23'h000007), //0.0003979
	.b2(23'h000003) //0.000199
	); 

Filtro #(
	.p(p),
	.f(f)
) HPBass(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPBass),
	.yk(yk_HPBass),
	.a1(23'h007fbe), //1.996
	.a2(23'h7fc042), //-0.996
	.b0(23'h003fdf), //0.998
	.b1(23'h7f8042), //-1.996
	.b2(23'h003fdf)  //0.998
	);
 
Filtro #(
	.p(p),
	.f(f)
) LPMed(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPMed),
	.a1(23'h00423d), //1.035
	.a2(23'h7fe876), //-0.3678
	.b0(23'h000552), //0.08316
	.b1(23'h000110), //0.1663
	.b2(23'h000552)  //0.08316
	); 

Filtro #(
	.p(p),
	.f(f)
) HPMed(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPMed),
	.yk(yk_HPMed),
	.a1(23'h007d71), //1.96
	.a2(23'h7fc287), //-0.9605
	.b0(23'h004000), //1
	.b1(23'h7f8000), //-2
	.b2(23'h004000)  //1
	); 

Filtro #(
	.p(p),
	.f(f)
) LPHigh(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk(uk_LPHigh),
	.a1(23'h7f9a2d), //-1.591 23'b111 1111 1001 1010 0010 1101
	.a2(23'h7fd5a7), //-0.6617 23'b111 1111 1101 0101 1010 0111
	.b0(23'h00340b), //0.8132 23'b000 0000 0011 0100 0000 1011
	.b1(23'h006810), //1.626 23'b000 0000 0110 1000 0001 0000
	.b2(23'h00340b)  //0.8132 23'b000 0000 0011 0100 0000 1011
	); 

Filtro #(
	.p(p),
	.f(f)
) HPHigh(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk_LPHigh),
	.yk(yk_HPHigh),
	.a1(23'h00423d), //1.035 23'b000 0000 0100 0010 0011 1101
	.a2(23'h7fe876), //-0.3678 23'b111 1111 1110 1000 0111 0110
	.b0(23'h002672), //0.6007 23'b000 0000 0010 0110 0111 0010
	.b1(23'h004cdd), //1.201 23'b000 0000 0100 1100 1101 1101
	.b2(23'h002672)  //0.6007 23'b23'b000 0000 0010 0110 0111 0010
	); 

endmodule

