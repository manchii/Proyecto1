`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    Identificador
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

module Identificador(
	//Dato entrante del teclado
	input wire [7:0] Dato_rx,
	//Señal que habilita cuando tomar el dato despues del 'F0'
	input wire filtro_enable,
	//Señales de control
	output reg ctrl,
	output reg enter,
	output reg dato
    );

	wire key;

	//Comportamiento del identificador de tecla
	always @*
	begin
		ctrl = 0;
		enter = 0;
		dato = 0;
		if(filtro_enable == 1'b1)
		begin		
			ctrl = (Dato_rx == 8'h14) ? 1'b1 : 1'b0;
			enter = (Dato_rx == 8'h5a) ? 1'b1 : 1'b0;
			dato = key;
		end
	end
	assign key = 		(Dato_rx == 8'h45) ? 1'b1 : //'0'	
				(Dato_rx == 8'h16) ? 1'b1 : //'1'
				(Dato_rx == 8'h1e) ? 1'b1 : //'2'
				(Dato_rx == 8'h26) ? 1'b1 : //'3'
				 1'b0;	
	

endmodule

