// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/14/20
// Lab 2 mux2x1.sv

// Input with a 1-bit selector and a 2-bit input,
// Selects either bit of the 2-bit input by the 1-bit selector to output.
`timescale 1ns/10ps
module mux2x1 (selector, in, out);
	input logic  selector;
	input logic  [1: 0]in;
	output logic out;
	
	logic notSel;
	logic sel1, sel2;
	
	not #50 sel_a (notSel, selector); //negate selector
	and #50 a (sel1, in[0], notSel);
	and #50 b (sel2, in[1], selector); 
	 
	or #50 outOr (out, sel1, sel2); 
	
endmodule

// Testbench for the mux2x1 (tested all combinations)
module mux2x1_testbench();
	logic selector, out, clk;
	logic  [1: 0]in;
	
	mux2x1 dut (.*);
	
	initial begin
		clk <= 0;
		forever #500 clk <= ~clk;
	end

	initial begin 
		selector <= 0; in <= 10;  @(posedge clk);
		selector <= 1; in <= 10; @(posedge clk); 
	
		$stop;
	end
endmodule