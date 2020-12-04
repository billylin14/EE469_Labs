// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/21/20
// Lab 2 fullAdder64bit.sv

// Takes two 64-bit inputs and select signal. Calculates addition when select is low, subtraction when select is high.
// Outputs the 64-bit result and carryout bit. Outputs overflow, negative, zero, and carryout flags.
`timescale 1ns/10ps

module fullAdder64bit (A, B, sel, result, overflow, negative, zero, carryout);
	input logic [63:0] A, B;
	input logic sel;
	output logic overflow, negative, zero, carryout;
	output logic [63:0] result;
	
	logic [63:0] carrout;
	logic [63:0] realB;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++)begin: buildXor
			xor #0.05 (realB[i], B[i], sel);
		end
	endgenerate
	
	fullAdder firstBit (.in1(A[0]), .in2(realB[0]), .cin(sel), .result(result[0]), .cout(carrout[0]));
	
	genvar j;
	generate
		for (j = 1; j < 64; j++)begin: buildAdders
			fullAdder add (.in1(A[j]), .in2(realB[j]), .cin(carrout[j-1]), .result(result[j]), .cout(carrout[j]));
		end
	endgenerate
	
	assign negative = result[63]; //check it
	assign carryout = carrout[63];
	xor #0.05 (overflow, carrout[63], carrout[62]);
	norGate64x1 norgate (.in(result), .out(zero));
	
endmodule

module fullAdder64bit_testbench();
	logic [63:0] A, B;
	logic sel, clk;
	logic overflow, negative, zero, carryout;
	logic [63:0] result;
	
	fullAdder64bit dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end
	
	initial begin
		//additions
		sel <= 0; 	A <= 64'h0000000000000000; B <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //flags are 0
						A <= 64'h8000000000000000; B <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //overflow = 1
						A <= 64'hFFFFFFFFFFFFFFF0; B <= 64'h0000000000000001; @(posedge clk); //negative = 1
						A <= 64'hFFFFFFFFFFFFFFFF; B <= 64'h0000000000000001; @(posedge clk); //zero = 1
						A <= 64'hFFFFFFFFFFFFFFFF; B <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk); //carryout = 1
		//subtractions
		sel <= 1; 	A <= 64'h0000000000000002; B <= 64'h0000000000000001; @(posedge clk); //flags are 0
						A <= 64'h8000000000000000; B <= 64'h0000000000000001; @(posedge clk); //overflow = 1
						A <= 64'h0000000000000002; B <= 64'h0000000000000005; @(posedge clk); //negative = 1
						A <= 64'h0000000000000001; B <= 64'h0000000000000001; @(posedge clk); //zero = 1
						A <= 64'h8000000000000000; B <= 64'h0000000000000001; @(posedge clk); //carryout = 1
		$stop;
	end
endmodule
		
		
	