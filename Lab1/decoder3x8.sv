// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/13/20
// Lab 1 decoder3x8.sv

// Input with a write-enable signal and a 3-bit select-signal 
// Outputs a 8-bit signal that has a 1 in the bit indicated by the select-signal when enable is on..
// Decoder is a 3x8 decoder built from one 1x2 decoder and two 2x4 decoders.
module decoder3x8 (enable, in, out);
	input logic enable;
	input logic [2:0] in;
	output logic [7:0] out;
	
	logic [1:0] sel;
	
	decoder1x2 selector (.enable(enable), .in(in[2]), .out(sel));
	
	decoder2x4 dec1 (.enable(sel[0]), .in(in[1:0]), .out(out[3:0]));
	decoder2x4 dec2 (.enable(sel[1]), .in(in[1:0]), .out(out[7:4]));
	
endmodule

// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder_3x8_testbench();
	
	logic enable, clk;
	logic [2:0] in;
	logic [7:0] out;
	
	decoder3x8 dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		enable <= 0; @(posedge clk); 
		enable <= 1; in <= 3'b111; @(posedge clk); 
		enable <= 1; in <= 3'b110; @(posedge clk); 
		enable <= 1; in <= 3'b101; @(posedge clk); 
		enable <= 1; in <= 3'b100; @(posedge clk); 
		enable <= 0; in <= 3'b111; @(posedge clk); 
	
		$stop;
	end
endmodule
