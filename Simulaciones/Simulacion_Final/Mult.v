`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Mult
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
module Mult#(
	parameter f = 10, // Parte decimal
	parameter p = 5, //Parte entera
	parameter Width = f+p+1//El ancho de bits
)
( 
	//Operandos
	input wire signed [Width-1:0] A,
	input wire signed [Width-1:0] B,
	//Resultado
	output reg signed [Width-1:0] Y
);
	//Multiplicación binaria 
	wire signed [2*Width-1:0] mult;
	assign mult = A*B;
	//Condición de overflow
	wire overflow, underflow;
	assign overflow = 	(A=={Width{1'b0}} | B=={Width{1'b0}})? 1'b0: //Caso con cero
				(A[Width-1]==B[Width-1]) ? (|mult[2*Width-1:(2*f)+p]) //Signo positivo
				: 1'b0 ;				//Overflow si no hay extensión de signo en el 2do bloque de magnitud
	assign underflow = 	(A=={Width{1'b0}} | B=={Width{1'b0}})? 1'b0 : //Caso con cero
				(A[Width-1]!=B[Width-1]) ? ~(&mult[2*Width-1:2*f+p]) : //Signo negativo
				1'b0 ;					//Underflow si no hay extensión de signo en el 2do bloque de magnitud

	always@*
		Y = 	overflow 	? {1'b0,{(Width-1){1'b1}}} : //Si hay overflow se satura el resultado en 0111...
			underflow 	? {1'b1,{(Width-1){1'b0}}} : //Si hay underflow se satura el resultado en 1000...
			{mult[2*Width-1],mult[2*Width-3-p:f]};	   //en caso contrario se deja el mismo resultado de la multiplicación binaria

endmodule
