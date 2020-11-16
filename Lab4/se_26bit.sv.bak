module se_19bit (in, out);
	input logic [18:0] in;
	output logic [63:0] out;
	
	assign out = {{45{in[19]}}, in};
endmodule

module se_19bit_testbench();
	logic [18:0] in;
	logic [63:0] out;
	logic clk;
	
	se_19bit dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin
		in <= 19'b0111111111111111111; @(posedge clk);
		in <= 19'b1111111111111111111; @(posedge clk);
		$stop;
	end
endmodule
