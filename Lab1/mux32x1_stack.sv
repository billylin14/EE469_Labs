module mux32x1_stack #(parameter WIDTH = 64)(select, in, out);
	
	input logic [4:0]select;
	input logic [31:0]in[WIDTH-1:0]; //maybe change dimensions: [second]in[first]
	output logic [WIDTH-1:0]out;
	
	genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin: buildMux
			mux32x1 muxxie (.select(select), .in(in[i]), .out(out[i]));
		end
	endgenerate
	
endmodule

module mux32x1_stack_testbench();
	logic [63:0]out, clk;
	logic [4:0]select;
	logic [31:0]in[63:0];
	
	mux32x1_stack dut (.*);
	
	initial begin
		clk <= 0;
		forever #5000 clk <= ~clk;
	end
	
	always_comb begin
		for (int i = 0; i < 64; i++) begin
			in[i] = i;
		end
	end
	
	initial begin 
		for(int i = 0; i < 64; i++) begin
			select <= i; @(posedge clk);
		end
//		select <= 5'b00000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b00001; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b00110; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b01100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b10000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b10100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b11000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b11100; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
//		select <= 5'b00000; in <= 32'b11110000111100001111000011110000;  @(posedge clk);
		
		$stop;
	end
endmodule