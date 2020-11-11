// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 se.sv

// Input with a specified width of data, 
// Outputs a sign-extended data with a width of 64 bits.

`timescale 1ns/10ps
module se #(parameter WIDTH = 9) (in, out);
	input logic [WIDTH-1:0] in;
	output logic [63:0] out;
	
	assign out = {{64-WIDTH{in[WIDTH-1]}}, in}; //is this allowed?
endmodule

module se_testbench #(parameter WIDTH = 9) ();
	logic [WIDTH-1:0] in;
	logic [63:0] out;
	logic clk;
	
	se dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin
		in <= 9'b011111111; @(posedge clk);
		in <= 9'b111111111; @(posedge clk);
		$stop;
	end
endmodule
