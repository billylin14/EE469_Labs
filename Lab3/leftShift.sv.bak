`timescale 1ns/10ps

module leftShift #(paramter SHAMT = 2) (in, out);
	input logic [63:0] in;
	output logic [63:0] out;
	
	assign out[63:SHAMT] = in[63-SHAMT:0];
	assign out[SHAMT-1:0] = SHAMT{1'b0};
endmodule

module leftShift_testbench();
	logic [63:0] in, out;
	logic clk;
	
	leftShift #(2) dut (.*);
	
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
	
	