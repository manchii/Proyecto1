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
// Description:100MHz/133 -> /17050 ->cs
//17
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div(
	input wire clk, rst, 
//	output wire fall_edge_cs, fall_edge_sclk,
	output wire cs,sclk
);

reg[7:0] counter_sclk, counter_sclk_next;
reg[4:0] counter_cs, counter_cs_next;

always@(posedge clk, posedge rst)
begin
	if(rst)
		counter_sclk <= 8'b0;
	else
		counter_sclk <= counter_sclk_next;

end

always@(posedge sclk, posedge rst)
begin
	if(rst)
		counter_cs <= 5'b0;
	else
		counter_cs <= counter_cs_next;
end

always@*
begin
	counter_sclk_next = (counter_sclk==8'd132)? 8'b0 : counter_sclk + 1'b1;
	counter_cs_next = (counter_cs==5'd16)? 5'b0 : counter_cs + 1'b1;
end

assign cs = (counter_cs==5'd16);
assign sclk = (counter_sclk==8'd132);

endmodule
