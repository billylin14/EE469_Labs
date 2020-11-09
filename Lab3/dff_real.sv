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