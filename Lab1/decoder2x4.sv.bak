// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/14/20
// Lab 1 decoder2x4.sv

// Input with a 1-bit enable signal, a 2-bit input signal
// Outputs a 4-bit signal that has a 1 in the bit indicated by the input signal when enable is on.
// A 2x4 decoder is built from three 1x2 decoders.
module decoder2x4 (enable, in, out);
	input logic enable;
	input logic [1:0] in;
	output logic [3:0] out;
	
	logic [1:0] sel;
	
	decoder1x2 selector (.enable(enable), .in(in[1]), .out(sel));
	decoder1x2 dec1 (.enable(sel[0]), .in(in[0]), .out(out[1:0]));
	decoder1x2 dec2 (.enable(sel[1]), .in(in[0]), .out(out[3:2]));
endmodule

// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder_2x4_testbench();
	
	logic enable, clk;
	logic [1:0] in;
	logic [3:0] out;
	
	decoder2x4 dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		enable <= 0; @(posedge clk); 
		enable <= 1; in <= 2'b11; @(posedge clk); 
		enable <= 1; in <= 2'b10; @(posedge clk); 
		enable <= 1; in <= 2'b01; @(posedge clk); 
		enable <= 1; in <= 2'b00; @(posedge clk); 
		enable <= 0; in <= 2'b11; @(posedge clk); 
	
		$stop;
	end
endmodule
