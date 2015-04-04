`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Receive_ADC
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
module Receive_adc(
	input wire clk, rst,
	input wire sdata, sclk, cs, rx_en,
	output reg rx_done_tick,
	output wire [11:0] dout
);
localparam [1:0]
	idle = 2'b00,
	dps = 2'b01,
	load = 2'b10;

//Filtro para francos negativos de la señal CS
//Inicio
reg [7:0] filter_reg;
wire [7:0] filter_next;
reg f_cs_reg;
wire f_cs_next;

wire fall_edge;

always @(posedge clk, posedge rst)
begin	
	if (rst)
	begin
		filter_reg <= 0;
		f_cs_reg <= 0;
	end
	else
	begin
		filter_reg <= filter_next;
		f_cs_reg <= f_cs_next;
	end
end

assign filter_next = {cs, filter_reg[7:1]};
assign f_cs_next = 	(filter_reg == 8'hff) ? 1'b1 :
			(filter_reg == 8'h00) ? 1'b0 :
			f_cs_reg;
assign fall_edge = f_cs_reg & ~f_cs_next;
//Fin

//Filtro para francos positivos de la señal SCLK
//Inicio
reg [1:0] filter_reg_sclk;
wire [1:0] filter_next_sclk;
reg f_sclk_reg;
wire f_sclk_next;

wire pos_edge;

always @(posedge clk, posedge rst)
begin	
	if (rst)
	begin
		filter_reg_sclk <= 0;
		f_sclk_reg <= 0;
	end
	else
	begin
		filter_reg_sclk <= filter_next_sclk;
		f_sclk_reg <= f_sclk_next;
	end
end

assign filter_next_sclk = {cs, filter_reg_sclk[1]};
assign f_sclk_next = 	(filter_reg_sclk == 2'h3) ? 1'b1 :
			(filter_reg_sclk == 2'h0) ? 1'b0 :
			f_cs_reg;
assign pos_edge = ~f_sclk_reg & f_sclk_next;
//Fin


//Máquina de estados

reg [1:0] state_reg, state_next;
reg [3:0] n_reg, n_next;
reg [11:0] b_reg,b_next;

always @(posedge clk, posedge rst)
begin
	if (rst)
	begin
		state_reg <= idle;
		n_reg <= 0;
		b_reg <= 0;
	end
	else
	begin
		state_reg <= state_next;
		n_reg <= n_next;
		b_reg <= b_next;
	end
end

always @*
begin
	state_next = state_reg;
	rx_done_tick = 1'b0;
	n_next = n_reg;
	b_next = b_reg;
	case (state_reg)
	idle:
		if(fall_edge & rx_en)
		begin
			n_next = 4'b1111;
			state_next = dps;
		end
	dps:
		if(pos_edge)
		begin
			if(n_reg<13)
				b_next = {b_reg[10:0], sdata};
			if (n_reg==1)
				state_next = load;
			else
				n_next = n_reg-1'b1;
		end
	load:
		begin
		state_next = idle;
		rx_done_tick = 1'b1;
		end
	endcase
end

assign dout = b_reg;

endmodule
