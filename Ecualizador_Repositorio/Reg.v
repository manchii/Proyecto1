`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Register
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
module Reg#(
	parameter Width = 16
)
( 
	input wire clk,rst,enable,
	input wire [Width-1:0] A,
	output wire [Width-1:0] Y
);

reg [Width-1:0] Data, Data_next;

always@(posedge clk, posedge rst)
	if(rst)
		Data <= {Width{1'b0}};
	else
		Data <= Data_next;

always@*
begin
	Data_next = Data;
	if(enable)
		Data_next = A;
end

assign Y = Data;

endmodule
