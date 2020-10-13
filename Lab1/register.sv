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
module register #(parameter WIDTH=64) (wrData, dOut, reset, clk, wrEn);
	input logic [WIDTH-1:0] wrData;
	input logic reset, clk, wrEn;
	output logic [WIDTH-1:0] dOut;
	initial assert (WIDTH > 0);
	
	genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin: buildReg
			D_FF diff (.q(dOut[i]), .d((wrEn & wrData[i]) || (~wrEn & dOut[i])), .reset, .clk);
		end
	endgenerate
endmodule

//Simulates the register module
`timescale 1 ps / 1 ps
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


	