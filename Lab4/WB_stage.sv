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
