module se #(parameter WIDTH = 9) (in, out);
	input logic [WIDTH-1:0] in;
	output logic [63:0] out;
	
	assign out = {{64-WIDTH{in[WIDTH-1]}}, in}; //is this allowed?
endmodule

module se_testbench #(parameter WIDTH = 9) ();
	logic [WIDTH-1:0] in;
	logic [63:0] out;
	logic clk;
	
	se dut (.*);
	
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
