`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    DecodificadorTecla
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

module DecodificadorTecla(
	//Dato entrante del teclado
	input wire [7:0] Dato_rx,
	//Señal para guardar
	input wire salvar,
	//Señal que indica la clase de dato esperado
	input wire [1:0] EstadoTipoDato,
	//Señal clk y rst
	input wire clk,rst,
	//variables programables
	output wire [1:0] Gain1,
	output wire [1:0] Gain2,
	output wire [1:0] Gain3
    );
localparam [1:0]
	gain1 = 2'h1,
	gain2 = 2'h2,
	gain3 = 2'h3;

reg [1:0] gain1_reg, gain1_sig;
reg [1:0] gain2_reg, gain2_sig;
reg [1:0] gain3_reg, gain3_sig;
wire [1:0] gain_deco;

	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			gain1_reg <= 2'b0;
			gain2_reg <= 2'b0;
			gain3_reg <= 2'b0;
		end
		else
		begin
			gain1_reg <= gain1_sig;
			gain2_reg <= gain2_sig;
			gain3_reg <= gain3_sig;	
		end
	end

	always@*
	begin
		gain1_sig = gain1_reg;
		gain2_sig = gain2_reg;
		gain3_sig = gain3_reg;
		if(salvar)
		begin
			case(EstadoTipoDato)
				gain1:
					gain1_sig = gain_deco;
				gain2:
					gain2_sig = gain_deco;
				gain3:
					gain3_sig = gain_deco;
			endcase
		end
	end	
	
	assign gain_deco = 	(Dato_rx == 8'h45) ? 2'b0 :	
				(Dato_rx == 8'h16) ? 2'b1 :
				(Dato_rx == 8'h1e) ? 2'b10 : 
				2'b11;

	assign Gain1 = gain1_reg;
	assign Gain2 = gain2_reg;
	assign Gain3 = gain3_reg;

endmodule

