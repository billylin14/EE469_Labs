// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/21/20
// Lab 2 fullAdder.sv

// Takes two single bit inputs and carry-in bit and calculates addition.
// Outputs the result and carry out bit.
`timescale 1ns/10ps
module fullAdder (in1, in2, cin, result, cout);

	input logic in1, in2, cin;
	output logic result, cout;
	
	logic aAndB, cinAndA, cinAndB;
	
	xor #0.05 (result, in1, in2, cin);
	and #0.05 (aAndB, in1, in2);
	and #0.05 (cinAndA, in1, cin);
	and #0.05 (cinAndB, cin, in2);
	or #0.05 (cout, aAndB, cinAndA, cinAndB); //cout = A&B | cin&A | cin&B;
	
endmodule

module fullAdder_testbench();

		logic in1, in2, cin;
		logic result, cout;
		
		fullAdder dut (.*);
		
		integer i;
		initial begin
			
				for (i=0; i<2**3;i++) begin //2**3 -> 2 to the power 3 (x**y), x inputs: 2**x
				 {in1, in2, cin} = i; #500;
				end //for loop
		
		end //initial
		
			
endmodule
