// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 pc.sv

// Input with a 64-bit of the previous program counter and a reset signal
// Stores the value of the previous program counter and passes it to the next cycle
// Resets to 0 when reset signal is high.

`timescale 1ns/10ps

module pc (in, out, clk, reset);
	input logic [63:0] in;
	output logic [63:0] out;
	input logic clk, reset;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++)begin: build64bitPC
			D_FF smallPC (.q(out[i]), .d(in[i]), .reset, .clk);
		end
	endgenerate
endmodule

module pc_testbench();
	logic [63:0] in, out;
	logic clk, reset;
	
	pc dut (.*);
	
	initial begin
		clk <= 0;
		forever #0.05 clk <= ~clk;
	end

	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		in <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk);
		in <= 64'h0000000000000001; @(posedge clk);
		reset <= 1; @(posedge clk); @(posedge clk);
		$stop;
	end
endmodule
	