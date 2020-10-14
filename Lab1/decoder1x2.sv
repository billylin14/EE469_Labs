//1:2 decoder with enable
module decoder_1_to_2 (enable, in, out);
	input logic enable, in;
	output logic [1:0] out;
	logic inNot;
	
	not n0 (inNot, in);
	and a0 (out[1], in, enable);
	and a1 (out[0], inNot, enable);
	
endmodule

// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder_1x2_testbench();
	
	logic enable, in;
	logic [1:0] out;
	
	decoder dut (.*);
	
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