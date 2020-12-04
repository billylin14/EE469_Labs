// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 mux4x1.sv

// Input with a 2-bit selector, 3-bit input data,
// Acts like a 4x1 multiplexer and Outputs 1-bit result based on selector.

// When selector = 0, output LSB of in
// When selector = 3, output MSB of in
`timescale 1ns/10ps
module mux4x1 (input logic [1:0] selector, 
					input logic [3:0] in,
					output logic out);
					
	logic m1Out, m2Out;
	
	mux2x1 m1 (.selector(selector[0]), .in(in[1:0]), .out(m1Out));
	mux2x1 m2 (.selector(selector[0]), .in(in[3:2]), .out(m2Out));
	mux2x1 m3 (.selector(selector[1]), .in({m2Out, m1Out}), .out(out));
endmodule

module mux4x1_testbench();
	logic [1:0] selector;
	logic [3:0] in;
	logic out;
	
	mux4x1 dut (.*);
	
	initial begin
		in <= 4'b1010; selector <= 2'b00; #50;
		in <= 4'b1010; selector <= 2'b01; #50;
		in <= 4'b1010; selector <= 2'b10; #50;
		in <= 4'b1010; selector <= 2'b11; #50;
		$stop;
	end
endmodule
