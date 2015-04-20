`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    18:56:38 02/23/2015 
// Design Name: 
// Module Name:    Driver_7seg
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Display: |Disp4|Disp3|Disp2|Disp1|
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Driver_7seg(
	input wire clk_disp,rst, //Clock y reset
	//Entradas para mostrar en los 4 displays
	input wire [6:0] Disp1,
	input wire [6:0] Disp2, 
	input wire [6:0] Disp3,
	input wire [6:0] Disp4,
	//Salidas para activar los displays
	output reg [6:0] Catodo,
	output reg [3:0] Seleccion
);

reg [2:0] estado_actual, estado_siguiente;

//Declaracion simbolica de los estados de la maquina de estados del driver
localparam [2:0] 
	idle = 3'b000,
	disp1 = 3'b001,
	disp2 = 3'b010,
	disp3 = 3'b011,
	disp4 = 3'b100;

//Comportamiento ante los cambios de clock y reset de la maquina de estados
always@(posedge clk_disp, posedge rst)
begin
	if(rst)
		estado_actual <= disp1;
	else
		estado_actual <= estado_siguiente;
end

//Comportamiento de la maquina de estado
always@*
begin
	Catodo = 7'hff; 	//Se muestra en un reset
	Seleccion = 4'hf;	//Se muestra en un reset
	case(estado_actual)
		idle:
		//Estado ante el Reset
		begin
			estado_siguiente = disp1;
		end
		disp1:
		//Se enciende el display de Unidades
		begin
			estado_siguiente = disp2;
			Catodo = Disp1;
			Seleccion = 4'b1110;
		end
		disp2:
		//Se enciende el display de Decenas
		begin
			estado_siguiente = disp3;
			Catodo = Disp2;
			Seleccion = 4'b1101;
		end
		disp3:
		//Se enciende el display de actividad, muestra una "V" o "A"
		begin
			estado_siguiente = disp4;
			Catodo = Disp3;
			Seleccion = 4'b1011;
		end
		disp4:
		//Se enciende el display del # de estado
		begin
			estado_siguiente = disp1; //Vuelve a Unidades
			Catodo = Disp4;
			Seleccion = 4'b0111;
		end
		default:
			estado_siguiente = disp1;
	endcase
end
endmodule
