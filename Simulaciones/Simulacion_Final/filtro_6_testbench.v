`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:01:38 04/26/2015
// Design Name:   Filtros_con_6
// Module Name:   /home/kaalfaro/LabDigitales/Ecualizador/Proyecto6Filtros/filtro_6_testbench.v
// Project Name:  Proyecto6Filtros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Filtros_con_6
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module filtro_6_testbench;

	// Inputs
	reg [22:0] uk;
	reg sclk;
	reg rst;
	reg enable;

	// Outputs
	wire [22:0] yk_HPBass;
	wire [22:0] yk_HPMed;
	wire [22:0] yk_HPHigh;

	// Instantiate the Unit Under Test (UUT)
	Filtros_con_6 uut (
		.uk(uk), 
		.sclk(sclk), 
		.rst(rst), 
		.enable(enable), 
		.yk_HPBass(yk_HPBass), 
		.yk_HPMed(yk_HPMed), 
		.yk_HPHigh(yk_HPHigh)
	);


	reg [22:0] datos_uk [0:1000];
	integer i;
	integer Output_bass,Output_med,Output_high;

	initial begin
		uk = 0;
		sclk = 0;
		rst = 1;
		enable = 0;
		$readmemb("sin.txt", datos_uk);
		Output_bass = $fopen("output_bass.txt","w");
		Output_med = $fopen("output_med.txt","w");
		Output_high = $fopen("output_high.txt","w");
		repeat(10)@(posedge sclk);
		rst = 0;
	end


	initial begin
	@(negedge rst);
	repeat(10) @(posedge sclk);
		for(i = 0; i<1001; i=i+1)
		begin
			@(posedge sclk);
			uk = datos_uk[i];
			enable = 1'b1;
			@(posedge sclk) 
			begin 
				$fwrite(Output_bass,"%b\n",yk_HPBass);
				$fwrite(Output_med,"%b\n",yk_HPMed);
				$fwrite(Output_high,"%b\n",yk_HPHigh);
			end
			enable = 1'b0;
			repeat(15)@(posedge sclk);
		end
		$stop;
	end

	initial forever begin
		#500 sclk = ~sclk;
	end
      
endmodule


