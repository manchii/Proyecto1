`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Send_dac
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
module Send_dac(
	input wire sclk, rst,
	input wire [11:0] data,
	input wire desp_enable,
	output wire sdata
);

reg [15:0] reg_desp, reg_desp_next;


//Registro serial-paralelo
always@(posedge sclk, posedge rst)
begin
	if(rst)
		reg_desp <= 16'b0;
	else
		reg_desp <= reg_desp_next;
end

always@*
begin
	reg_desp_next = {{4{1'b0}},data};
	if(desp_enable)
		reg_desp_next = {reg_desp[14:0],sdata};
end

assign sdata = reg_desp[15];



endmodule