module fullAdder (in1, in2, cin, result, cout);

	input logic in1, in2, cin;
	output logic result, cout;
	
	logic aAndB, cinAndA, cinAndB;
	
	xor #50 (result, in1, in2, cin);
	and #50 (aAndB, in1, in2);
	and #50 (cinAndA, in1, cin);
	and #50 (cinAndB, cin, in2);
	or #50 (cout, aAndB, cinAndA, cinAndB); //cout = A&B | cin&A | cin&B;
	
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
