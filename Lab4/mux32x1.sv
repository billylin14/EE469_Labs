// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/14/20
// Lab 1 mux32x1.sv

// Input with a 5-bit select-signal, a 32-bit input signals,
// Outputs a 1-bit signal that was indicated by the select-signal.
// The 32x1 multiplexer is built from 5 8x1 multiplexers.
module mux32x1 (select, in, out);
	input logic [4:0]select;
	input logic [31:0]in;
	output logic out;
	logic x1, x2, x3, x4;
	
	mux8x1 m1 (.selector(select[2:0]), .in(in[31:24]), .out(x1));
	mux8x1 m2 (.selector(select[2:0]), .in(in[23:16]), .out(x2));
	mux8x1 m3 (.selector(select[2:0]), .in(in[15:8]), .out(x3));
	mux8x1 m4 (.selector(select[2:0]), .in(in[7:0]), .out(x4));
	mux8x1 m5 (.selector({1'b0,select[4:3]}), .in({4'b000, x1, x2, x3, x4}), .out(out));
	
	
endmodule

//Simulates the mux32x1 I/O
module mux32x1_testbench();
	logic out, clk;
	logic [4:0]select;
	logic [31: 0]in;
	
	mux32x1 dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin 
		select <= 5'b00000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b00001; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b00110; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b01100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b10000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b10100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b11000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b11100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		select <= 5'b00000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		
		$stop;
	end
endmodule
