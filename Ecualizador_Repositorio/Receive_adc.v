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
	input wire sclk, rst,
	input wire cs,
	input wire sdata, rx_en,
	output wire rx_done_tick,
	output wire [11:0] dout
);

reg [11:0] reg_desp, reg_desp_next;
 
always@(negedge sclk, posedge rst)
begin
	if(rst)
		reg_desp <= 12'b0;
	else
		reg_desp <= reg_desp_next;
end

always@*
begin
	reg_desp_next = 12'b0;
	if(rx_en)
	begin
		reg_desp_next = reg_desp;
		if(~cs)
		begin
			reg_desp_next = {reg_desp[10:0],sdata};
		end
	end
end

assign dout = reg_desp;
assign rx_done_tick = rx_en & cs;

endmodule
