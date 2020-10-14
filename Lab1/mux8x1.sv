//8x1 mux
module mux8x1 (selector, in, out);
	input logic  [2:0] selector;
	input logic  [7:0] in;
	output logic out;
	
	logic x1, x2, x3, x4, y1, y2;
	
	mux2x1 mux1 (.selector(selector[0]), .in(in[1:0]), .out(x1));
	mux2x1 mux2 (.selector(selector[0]), .in(in[3:2]), .out(x2));
	mux2x1 mux3 (.selector(selector[0]), .in(in[5:4]), .out(x3));
	mux2x1 mux4 (.selector(selector[0]), .in(in[7:6]), .out(x4));
	mux2x1 mux5 (.selector(selector[1]), .in({x2, x1}), .out(y1));
	mux2x1 mux6 (.selector(selector[1]), .in({x4, x3}), .out(y2));
	mux2x1 mux7 (.selector(selector[2]), .in({y2, y1}), .out(out)); 
endmodule

module mux8x1_testbench();
	logic out, clk;
	logic [2:0]selector;
	logic [7: 0]in;
	
	mux8x1 dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end

	initial begin 
		selector <= 3'b000; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b001; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b010; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b011; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b100; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b101; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b110; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b111; in <= 8'b11110000;  @(posedge clk);
		selector <= 3'b000; in <= 8'b11110000;  @(posedge clk);
		
		$stop;
	end
endmodule
