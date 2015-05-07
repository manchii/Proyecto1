`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:28:09 05/04/2015
// Design Name:   top
// Module Name:   /home/kaalfaro/LabDigitales/Ecualizador/Proyecto6Filtros/top_testbench.v
// Project Name:  Proyecto6Filtros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_testbench;

	// Inputs
	reg clk;
	reg rst;
	reg sdata_adc;
	reg ps2d;
	reg ps2c;

	// Outputs
	wire sdata_dac;
	wire cs;
	wire sclk;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst(rst), 
		.sdata_adc(sdata_adc), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.sdata_dac(sdata_dac), 
		.cs(cs), 
		.sclk(sclk)
	);

	integer i,j,k;
	reg enable_ps2c;
	reg [10:0] mensaje_ps2 [0:13];
	reg [10:0] aux_ps2;
	reg [15:0] datos_adc [0:100];
	reg [15:0] aux_adc;
	integer Output_dac;
	reg fin_ps2;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		sdata_adc = 0;
		ps2d = 1'b1;
		ps2c = 1'b1;
		enable_ps2c = 1'b0;
		mensaje_ps2[0] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[1] = {2'b11,8'h14,1'b0}; //CTRL
		mensaje_ps2[2] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[3] = {2'b11,8'h5a,1'b0}; //ENTER
		mensaje_ps2[4] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[5] = {2'b11,8'h1e,1'b0}; //1
		mensaje_ps2[6] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[7] = {2'b11,8'h5a,1'b0}; //ENTER
		mensaje_ps2[8] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[9] = {2'b11,8'h45,1'b0}; //0
		mensaje_ps2[10] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[11] = {2'b11,8'h5a,1'b0}; //ENTER
		mensaje_ps2[12] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[13] = {2'b11,8'h45,1'b0}; //0
		aux_ps2 = 11'b0;
		aux_adc = 16'b0;
		$readmemb("ramp.txt", datos_adc);
		Output_dac = $fopen("output_dac.txt","w");
		repeat(10)@(posedge clk);
		rst = 0;
		fin_ps2 = 0;
	end

	initial begin
		@(negedge rst);
		for(j=0;j<14;j=j+1)
		begin
			aux_ps2=mensaje_ps2[j];
			repeat(5)@(posedge clk);
			enable_ps2c =1'b1;
			for(i = 0; i<11; i=i+1)
			begin
				ps2d = aux_ps2[i];
				@(posedge ps2c);
			end
			ps2d = 1;
			enable_ps2c = 1'b0;
		end
		fin_ps2 = 1;

	end
	
	initial begin
		@(negedge rst)
		while(~fin_ps2)
		begin	
			@(negedge cs);
			aux_adc = 16'h0800;
			for(k = 15; k>-1; k = k-1)
			begin
				sdata_adc = aux_adc[k];
				@(posedge sclk);
			end
		end
		for(j=0;j<101;j=j+1)		
		begin
			@(negedge cs);
			aux_adc = datos_adc[j];
			for(i = 15; i>-1; i = i-1)
			begin
				sdata_adc = aux_adc[i];
				$fwrite(Output_dac,"%b",sdata_dac);
				@(posedge sclk);
			end
			$fwrite(Output_dac,"\n");
		end
		$stop;
	end
      
	initial forever begin
		#5 clk = ~clk;
	end

	initial begin
		@(posedge enable_ps2c);
		while(enable_ps2c)
			#500 ps2c = ~ps2c;
	end
      

endmodule

