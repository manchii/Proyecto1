`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    18:56:38 02/23/2015 
// Design Name: 
// Module Name:    Top_adc
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Este módulo se encarga de comprobar el funcionamiento
//		del ADC mediante el display de los datos capturados
//		en el display de 7segmentos.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top_adc(
	input wire clk,rst, //clk de 100MHz, rst
	input wire sdata, //Puerto serial del ADC
	input wire rx_en, //Habilitación de carga
	output wire cs,sync,	//Puerto habilitación de toma de datos
	output wire sclk_adc, sclk_dac,	//clk dato serial
	output wire sdata_dac,
	//display del 7segmentos
	output wire [6:0] Catodo,
	output wire [3:0] Seleccion
);
//Señales auxiliares
wire rx_done_tick,clk_disp;
wire [11:0] dout,dato_capt;
wire [6:0] disp1,disp2,disp3;
wire desp_enable;
wire sclk;

assign sclk_adc = sclk;
assign sclk_dac = sclk;
assign sync = cs;

//Recepción de datos
Receive_adc Receive_adc_module (
    .sclk(sclk), 
    .rst(rst), 
    .sdata(sdata), 
    .rx_en(rx_en), 
    .rx_done_tick(rx_done_tick), 
    .dout(dout), 
    .cs(cs),
	 .desp_enable(desp_enable)
    );
//Generador del clock serial
clk_div clk_div_module (
    .clk(clk), 
    .rst(rst), 
    .sclk(sclk)
    );

Send_dac modulo_envio(
	.sclk(sclk), 
	.rst(rst),
	.data(dato_capt),
	.desp_enable(desp_enable),
	.sdata(sdata_dac)
);

//Registro de captura
Reg #(.Width(12)) Reg_module (
    .clk(sclk), 
    .rst(rst), 
    .enable(rx_done_tick), 
    .A(dout), 
    .Y(dato_capt)
    );

//Decodificador de binario a hexa para 7segmentos
Cod_bin_hex bin_hex_disp1 (
    .i(dato_capt[3:0]), 
    .o(disp1)
    );

Cod_bin_hex bin_hex_disp2 (
    .i(dato_capt[7:4]), 
    .o(disp2)
    );

Cod_bin_hex bin_hex_disp3 (
    .i(dato_capt[11:8]), 
    .o(disp3)
    );

//Generador de clk para display de 7segmentos
Clk_div_2n Clk_div_2_module(
    .clk(clk), 
    .rst(rst), 
    .clk_div(clk_disp)
    );


//Controlador del display de 7 segmentos
Driver_7seg Driver_7seg_module (
    .clk_disp(clk_disp), 
    .rst(rst), 
    .Disp1(disp1), 
    .Disp2(disp2), 
    .Disp3(disp3), 
    .Disp4(7'h0), 
    .Catodo(Catodo), 
    .Seleccion(Seleccion)
    );


endmodule
