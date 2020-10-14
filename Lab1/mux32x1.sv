//1:2 mux
module mux32x1 #(parameter WIDTH = 64, HEIGHT = 32)(enable, in, out);
	input logic enable;
	input logic [HEIGHT-1: 0]in[WIDTH-1: 0];
	output logic [WIDTH-1:0]out;
	logic inNot;
	
	
endmodule

