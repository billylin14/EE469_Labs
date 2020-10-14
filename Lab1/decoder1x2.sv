//1:2 decoder with enable
module decoder1x2 (enable, in, out);
	input logic enable, in;
	output logic [1:0] out;
	logic inNot;
	
	not #50 n0 (inNot, in);
	and #50 a0 (out[1], in, enable);
	and #50 a1 (out[0], inNot, enable);
	
endmodule

// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder_1x2_testbench();
	
	logic enable, in, clk;
	logic [1:0] out;
	
	decoder1x2 dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		enable <= 0; @(posedge clk);
		enable <= 1; in <= 0; @(posedge clk); 
		enable <= 1; in <= 1; @(posedge clk); 
		enable <= 0; in <= 0; @(posedge clk); 
		enable <= 0; in <= 1; @(posedge clk); 
	
		$stop;
	end
endmodule