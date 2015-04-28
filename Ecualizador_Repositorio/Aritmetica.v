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
module Aritmetica #(
	parameter p=8,
	parameter f=14,
	parameter Width = p+f+1
)
(
	input wire signed [Width-1:0] dato_adc,
	input wire sclk,rst,
	input wire enable,
	input wire [1:0] gain1,gain2,gain3,
	output wire signed [Width-1:0] dato_dac
);

wire signed [Width-1:0] uk,sum_yk1yk2,sum_yk1yk2yk3;
wire signed [Width-1:0] yk_HPBass_gain,yk_HPMed_gain,yk_HPHigh_gain;
wire signed [Width-1:0] yk_HPBass,yk_HPMed,yk_HPHigh;

Sum #(
	.Width(Width)
) Suma_quitar_offset
(
	.A(dato_adc),
	.B({{p+1{1'b1}},1'b1,{(f-1){1'b0}}}),
	.Y(uk)
);


Filtros_con_6 #(
	.p(p),
	.f(f)
) modulo_filtro_6(
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.uk(uk),
	.yk_HPBass(yk_HPBass),
	.yk_HPMed(yk_HPMed),
	.yk_HPHigh(yk_HPHigh)
	); 

Gain #(
	.p(p),
	.f(f),
	.Width(Width)
) gainBass(
	.yk(yk_HPBass),
	.gain_set(gain1),
	.ykgain(yk_HPBass_gain)
);

Gain #(
	.p(p),
	.f(f),
	.Width(Width)
) gainMed(
	.yk(yk_HPMed),
	.gain_set(gain2),
	.ykgain(yk_HPMed_gain)
);

Gain #(
	.p(p),
	.f(f),
	.Width(Width)
) gainHigh(
	.yk(yk_HPHigh),
	.gain_set(gain3),
	.ykgain(yk_HPHigh_gain)
);


Sum #(
	.Width(Width)
) Suma_parcial1
(
	.A(yk_HPBass_gain),
	.B(yk_HPMed_gain),
	.Y(sum_yk1yk2)
);

Sum #(
	.Width(Width)
) Suma_parcial2
(
	.A(sum_yk1yk2),
	.B(yk_HPHigh_gain),
	.Y(sum_yk1yk2yk3)
);


Sum #(
	.Width(Width)
) Suma_poner_offset
(
	.A(sum_yk1yk2yk3),
	.B({{p+1{1'b0}},1'b1,{(f-1){1'b0}}}),
	.Y(dato_dac)
);



endmodule

