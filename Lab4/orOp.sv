// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/21/20
// Lab 2 orOp.sv

// Gives the result from bitwise 64-bit OR operation of A and B
// Output zero and negative flag.
`timescale 1ns/10ps
module orOp (A, B, result, zero, negative);
	input logic		[63:0]	A, B;
	output logic		[63:0]	result;
	output logic					negative, zero;
	
	assign negative = result[63];
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: buildOrGates
			or #0.05 (result[i], A[i], B[i]);
		end
	endgenerate
	
		
	norGate64x1 norgate(.in(result), .out(zero));
	
endmodule

module orOp_testbench();
	logic		[63:0]	A, B;
	logic		[63:0]	result;
	logic					negative, zero, clk;
	
	orOp dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end
	
	initial begin
		A <= 1; B <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //this outputs 1 at 1st bit
		A <= 64'hFFFFFFFFFFFFFFFF; B <= 2; @(posedge clk); //this outputs 1 at 2nd bit
		A <= 64'h8000000000000000; B <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //this outputs 1 at 64th bit and negative flag = 1;
		A <= 0; B <= 0; @(posedge clk); //this outputs 0 and zero flag = 1;
		$stop;
	end
endmodule
