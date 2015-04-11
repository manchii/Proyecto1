`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaleb Alfaro e Irene Rivera
//
// Create Date: april/2015
// Design Name:
// Module Name: Filtro
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
module Filtro(
	input wire clk, rst,
	input wire signed [17:0] uk,
	input wire signed [17:0] a1, a2, b0, b1, b2,
	output reg signed [17:0] yk
);
reg signed [17:0] fk1,fk1_next;
reg signed [17:0] fk2,fk2_next;
wire signed [17:0] sum_uk_a1fk1_a2fk2; //fk
wire signed [17:0] sum_b0fk_b1fk1_b2fk2;

always@(posedge clk, posedge rst)
begin
	if(rst)
	begin
		yk <= 18'b0;
		fk1 <= 18'b0;
		fk2 <= 18'b0;
	end

	else
	begin
		yk <= sum_b0fk_b1fk1_b2fk2;
		fk1 <= sum_uk_a1fk1_a2fk2;
		fk2 <= fk1;
	end
end

assign sum_uk_a1fk1_a2fk2 = uk - a1*fk1 - a2*fk2;
assign sum_b0fk_b1fk1_b2fk2 = b0*sum_uk_a1fk1_a2fk2 + b1*fk1 + b2*fk2;

endmodule
