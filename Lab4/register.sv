// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/13/20
// Lab 1 register.sv

// Input with a clock, a reset signal, and a 1-bit data
// Stores the data and outputs the data at the next cycle.
module D_FF (q, d, reset, clk);
 output reg q;
 input d, reset, clk;
 always_ff @(posedge clk)
 if (reset)
	q <= 0; // On reset, set to 0
 else
	q <= d; // Otherwise out = d
endmodule 

// Input with a clock, a reset signal, and a write-enable signal 
// Creates a 64-bit register that stores a 64-bit data if write-enable is on, 0 otherwise.
// Outputs whatever stores in the register from the last clock cycle.
`timescale 1ns/10ps

module register #(parameter WIDTH=64) (wrData, dOut, reset, clk, wrEn);
	input logic [WIDTH-1:0] wrData;
	input logic reset, clk, wrEn;
	output logic [WIDTH-1:0] dOut;
	initial assert (WIDTH > 0);
	logic [WIDTH-1:0] temp1, temp2, notWrEn, d;
	
	genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin: buildReg
			and #0.05 (temp1[i], wrEn, wrData[i]);
			not #0.05 (notWrEn[i], wrEn);
			and #0.05 (temp2[i], notWrEn[i], dOut[i]);
			or  #0.05 (d[i], temp1[i], temp2[i]);
			
			D_FF diff (.q(dOut[i]), .d(d[i]), .reset, .clk); //(wrEn & wrData[i]) || (~wrEn & dOut[i])
																			 //    temp1						temp2
		end
	endgenerate
endmodule

//Simulates the register module
module register_dut_testbench #(parameter WIDTH=64) ();

	logic clk, reset, wrEn;
	logic [WIDTH-1:0] wrData, dOut;
	
	register dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		reset <= 1; @(posedge clk);
		reset <= 0;	wrEn <= 1; wrData = 10; @(posedge clk);
		reset <= 0; wrEn <= 0; wrData = 0;  @(posedge clk); @(posedge clk);
		reset <= 0; wrEn <= 1; wrData = 1000000;  @(posedge clk); 
		reset <= 0; wrEn <= 0; wrData = 0;  @(posedge clk); @(posedge clk);
		reset <= 1; @(posedge clk); @(posedge clk);
		$stop;
	end
endmodule


	