module se_26bit (in, out);
	input logic [25:0] in;
	output logic [63:0] out;
	
	assign out = {{38{in[25]}}, in};
endmodule

module se_26bit_testbench();
	logic [25:0] in;
	logic [63:0] out;
	logic clk;
	
	se_26bit dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin
		in <= 26'b01111111111111111111111111; @(posedge clk);
		in <= 26'b11111111111111111111111111; @(posedge clk);
		$stop;
	end
endmodule
