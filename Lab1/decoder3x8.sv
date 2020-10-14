//3:8 decoder with enable built using logic gates
module decoder_3_to_8 (enable, in, out);
	input logic enable;
	input logic [2:0] in;
	output logic [7:0] out;
	logic inInverted[2:0];
	
	nor nornor (out[0], enabl
	assign out[0] = enable & (~in[2] & ~in[1] & ~in[0]); 	//in: 000
	assign out[1] = enable & (~in[2] & ~in[1] & in[0]);	//in: 001
	assign out[2] = enable & (~in[2] & in[1] & ~in[0]);	//in: 010
	assign out[3] = enable & (~in[2] & in[1] & in[0]);		//in: 011
	assign out[4] = enable & (in[2] & ~in[1] & ~in[0]);	//in: 100
	assign out[5] = enable & (in[2] & ~in[1] & in[0]);		//in: 101
	assign out[6] = enable & (in[2] & in[1] & ~in[0]);		//in: 110
	assign out[7] = enable & (in[2] & in[1] & in[0]);		//in: 111
endmodule
