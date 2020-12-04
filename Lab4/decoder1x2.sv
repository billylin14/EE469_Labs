// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/14/20
// Lab 1 decoder1x2.sv

// Input with a 1-bit enable signal and a 1-bit encoded signal,
// Outputs a decoded 2-bit data that stores a 1 in the bit indicated by the input signal when enable is on.
// Outputs 0 when enable is off.
`timescale 1ns/10ps
module decoder1x2 (enable, in, out);
	input logic enable, in;
	output logic [1:0] out;
	logic inNot;
	
	not #0.05 n0 (inNot, in);
	and #0.05 a0 (out[1], in, enable);
	and #0.05 a1 (out[0], inNot, enable);
	
endmodule

// Simulates the decoder I/O
module decoder_1x2_testbench();
	
	logic enable, in, clk;
	logic [1:0] out;
	
	decoder1x2 dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		enable <= 0; @(posedge clk);
		enable <= 1; in <= 0; @(posedge clk); 
		enable <= 1; in <= 1; @(posedge clk); 
		enable <= 0; in <= 0; @(posedge clk); 
		enable <= 0; in <= 1; @(posedge clk); 
	
		$stop;
	end
endmodule