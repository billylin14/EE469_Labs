// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/21/20
// Lab 2 norGate64x1.sv

// Takes 64-bits input and outputs the result from NORing each bit together
`timescale 1ns/10ps

module norGate64x1 (in, out);
	input logic [63:0]in;
	output logic out;
	
	nor #0.05 (out, in[63], in[62], in[61], in [60], in[59], in[58], in[57], in[56], in[55],in[54], in[53],
				in[52], in[51], in[50], in[49], in[48], in[47], in[46], in[45], in[44], in[43], in[42], in[41], 
				in[40], in[39], in[38], in[37], in[36], in[35], in[34], in[33], in[32], in[31], in[30], in[29], 
				in[28], in[27], in[26], in[25], in[24], in[23], in[22], in[21], in[20], in[19], in[18], in[17], 
				in[16], in[15], in[14], in[13], in[12], in[11], in[10], in[9], in[8], in[7], in[6], in[5], in[4], 
				in[3], in[2], in[1], in[0]);
	
endmodule
		
module norGate64x1_testbench ();
	logic [63:0]in;
	logic out, clk;
	
	norGate64x1 dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end
	
	initial begin
		in <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //output should be 0
		in <= 64'h0000000000000001; @(posedge clk); //output should be 0
		in <= 64'h0000000000000000; @(posedge clk);
		in <= 64'h0010000000000000; @(posedge clk);
		$stop;
	end
endmodule