//2:4 decoder with enable built using logic gates
module decoder_2_to_4 (enable, in, out);
	input logic enable;
	input logic [1:0] in;
	output logic [3:0] out;
	
	assign out[0] = enable & (~in[1] & ~in[0]);				//in: 00
	assign out[1] = enable & (~in[1] & in[0]);				//in: 01
	assign out[2] = enable & (in[1] & ~in[0]);				//in: 10
	assign out[3] = enable & (in[1] & in[0]);					//in: 11
endmodule