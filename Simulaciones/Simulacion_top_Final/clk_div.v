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
	output wire sclk
);

reg[7:0] counter_sclk, counter_sclk_next;
wire pulse_sclk;


always@(posedge clk, posedge rst)
begin
	if(rst)
		counter_sclk <= 8'b0;
	else
		counter_sclk <= counter_sclk_next;

end

always@*
begin
	counter_sclk_next = (pulse_sclk)? 8'b0 : counter_sclk + 1'b1;
end

/*BUFG BUFG_sclk (
  .O(sclk), // 1-bit output: Clock buffer output
  .I(pulse_sclk)  // 1-bit input: Clock buffer input
);*/
assign pulse_sclk = (counter_sclk==8'd132);
assign sclk = pulse_sclk;
endmodule
