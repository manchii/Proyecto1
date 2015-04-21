`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:15:57 04/16/2015
// Design Name:   Mult
// Module Name:   /home/kaalfaro/LabDigitales/Ecualizador/ISE_Ecualizador/mult_testbench.v
// Project Name:  ISE_Ecualizador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mult
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mult_testbench;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;

	// Outputs
	wire [15:0] Y;

	// Instantiate the Unit Under Test (UUT)
	Mult uut (
		.A(A), 
		.B(B), 
		.Y(Y)
	);

	reg clk;
	integer Output;

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		clk = 0;
		Output = $fopen("output.txt","w");
		@(posedge clk) A = 16'h8000;
		B = 16'h8000;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'hffff;
		B = 16'h0;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'h5fff;
		B = 16'h0;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'hefff;
		B = 16'hefff;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'hefff;
		B = 16'h0;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'hf00f;
		B = 16'h0303;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'h800f;
		B = 16'hf300;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		@(posedge clk) A = 16'h8000;
		B = 16'h500f;
		@(posedge clk) $fwrite(Output,"%b	%b	%b\n",A,B,Y);
		$stop;
	end
	
	initial forever
	#10	clk = ~clk;
      
endmodule


