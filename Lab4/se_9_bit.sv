module se_9bit (in, out);
	input logic [8:0] in;
	output logic [63:0] out;
	
	assign out = {{55{in[8]}}, in};
endmodule

module se_9bit_testbench();
	logic [8:0] in;
	logic [63:0] out;
	logic clk;
	
	se_9_bit dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin
		in <= 9'b011111111; @(posedge clk);
		in <= 9'b111111111; @(posedge clk);
		$stop;
	end
endmodule
