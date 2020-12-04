// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 WB_Stage.sv

// Input with a clock, control signals, and data pipelined from the EX stage and from the MEM stage,
// Outputs the data to write back to the regfile in RF stage.

`timescale 1ns/10ps
module WB_stage  (input logic MOVsel,
						input logic [63:0] 	MOVout, wrBout,
						output logic [63:0] 	Dw);
	
	genvar i;
	generate
		for (i=0; i<64; i++)begin: build64BitMux
			mux2x1 MOVselector (.selector(MOVsel), .in({MOVout[i], wrBout[i]}), .out(Dw[i]));
		end
	endgenerate
endmodule
