// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 leftShift.sv

// Input with a shift amount (SHAMT) and a 64-bit data,
// Arithmetically shifts the data by the specified SHAMT.

`timescale 1ns/10ps

module leftShift (SHAMT, in, out);
	input logic [63:0] in;
	input logic [1:0] SHAMT;
	output logic [63:0] out;
	
	always_comb begin
		case (SHAMT)
			0: out = in;
			1: out = {in[62:0], 1'b0};
			2: out = {in[61:0], 2'b0};
			3: out = {in[60:0], 3'b0};
		endcase
	end
	
//	assign out[63:SHAMT] = in[63-SHAMT:0];
//	assign out[SHAMT-1:0] = {SHAMT{1'b0}};// ask ta easy way to do this

endmodule

module leftShift_testbench();
	logic [63:0] in, out;
	logic clk;
	logic [1:0] SHAMT;
	
	leftShift dut (.*);
	
	initial begin
		clk <= 0;
		forever #0.05 clk <= ~clk;
	end
	
	initial begin
		in <= 64'hFFFFFFFFFFFFFFFF; @(posedge clk);
		in <= 64'h1; @(posedge clk);
		in <= 64'h0; @(posedge clk);
		$stop;
	end
endmodule
	
	