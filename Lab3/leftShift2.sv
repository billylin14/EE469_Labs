`timescale 1ns/10ps

module leftShift2 (in, out);
	input logic [63:0] in;
	output logic [63:0] out;
	
	assign out[63:2] = in[61:0];
	assign out[1:0] = 2'b00;
endmodule

module leftShift2_testbench();
	logic [63:0] in, out;
	logic clk;
	
	leftShift2 dut (.*);
	
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
	
	