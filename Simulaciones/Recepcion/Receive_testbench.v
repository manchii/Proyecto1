`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:10:55 04/14/2015
// Design Name:   Receive_adc
// Module Name:   /home/kaalfaro/LabDigitales/Ecualizador/ISE_Ecualizador/Receive_testbench.v
// Project Name:  ISE_Ecualizador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Receive_adc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Receive_testbench;

	// Inputs
	reg sclk;
	reg rst;
	reg sdata;
	reg rx_en;

	// Outputs
	wire rx_done_tick;
	wire [11:0] dout;
	wire cs;

	// Instantiate the Unit Under Test (UUT)
	Receive_adc uut (
		.sclk(sclk), 
		.rst(rst), 
		.cs(cs), 
		.sdata(sdata), 
		.rx_en(rx_en), 
		.rx_done_tick(rx_done_tick), 
		.dout(dout)
	);

	integer i,j,Output;
	reg [15:0] mensaje [0:100];
	reg [11:0] datos [0:100];
	reg [11:0] aux;

	initial begin
		// Initialize Inputs
		sclk = 0;
		rst = 1;
		sdata = 0;
		rx_en = 0;
		i = 0;
		j=0;
		$readmemb("signal.txt", datos);
		Output = $fopen("output.txt","w");
		for(j=0;j<101;j=j+1)
		begin
			mensaje[j]={4'h0,datos[j]};
		end
		$fwrite(Output,"Entrada	Salida\n");
		
	end
	
	initial begin
		#1 rst =0;
		@(posedge cs) rx_en = 1'b1;
		for(j=0;j<100;j=j+1)
			begin
				@(negedge cs) aux=mensaje[j];
				for(i = 15; i>-1; i=i-1)
				begin
					sdata = aux[i];
					@(posedge sclk);
				end
				sdata = 1;
				@(posedge cs) $fwrite(Output,"%b	%b\n",datos[j],dout);
			end
		@(posedge sclk);
		rx_en = 1'b0;
		$stop;
	end
	
	initial forever begin
		#5 sclk = ~sclk;
	end
      
endmodule


