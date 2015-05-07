`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: 
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
module top #(
	parameter p=10,
	parameter f=14,
	parameter Width = p+f+1
)
(
	input wire clk, rst,
	input wire sdata_adc,
	input wire ps2d,ps2c,
	output wire sdata_dac,
	output wire cs,sclk
);

wire [1:0] gain1,gain2,gain3;
wire enable;
wire [11:0] data_adc;
wire desp_enable;
wire [Width-1:0] data_dac;


clk_div clk_div_modulo(
	.clk(clk), 
	.rst(rst),
	.sclk(sclk)
	);


Interfaz_ps2 modulo_ps2(
	.ps2d(ps2d),
	.ps2c(ps2c),
	.clk(clk),
	.rst(rst),
	.Gain1(gain1),
	.Gain2(gain2),
	.Gain3(gain3),
	.DatosListos()
	);

Receive_adc modulo_adc(
	.sclk(sclk),
	.rst(rst),
	.sdata(sdata_adc), 
	.rx_en(1'b1),
	.rx_done_tick(enable),
	.dout(data_adc),
	.cs(cs),
	.desp_enable(desp_enable)
	);

Aritmetica #(
	.p(p),
	.f(f),
	.Width(Width)
) Aritmetica_modulo
(
	.dato_adc({{(p+1){1'b0}},data_adc,2'b0}),
//	.clk(clk),
	.sclk(sclk),
	.rst(rst),
	.enable(enable),
	.gain1(gain1),
	.gain2(gain2),
	.gain3(gain3),
	.dato_dac(data_dac)
);

Send_dac modulo_dac(
	.sclk(sclk), 
	.rst(rst),
	.data(data_dac[f-1:2]),
	.sdata(sdata_dac),
	.desp_enable(desp_enable)
);

endmodule
