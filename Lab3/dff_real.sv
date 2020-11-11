// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 dff_real.sv

// Input with a 1-bit in, enable,
// Outputs a delayed input data from the previous cycle and holds the value when enable is OFF.

module dff_real (in, out, en, clk);
 output reg out;
 input in, en, clk;
 
 always_ff @(posedge clk)
 if (en) out <= in;
 
endmodule 

module dff_real_testbench();
	logic out, in, clk, en;
	dff_real dut(.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		en <= 0; @(posedge clk);
		en <= 1; in <= 0; @(posedge clk); 
		en <= 0; in <= 1; @(posedge clk); 
		en <= 0; in <= 0; @(posedge clk); 
		en <= 1; in <= 1; @(posedge clk);
		en <= 0; in <= 0; @(posedge clk); 	
	
		$stop;
	end
endmodule