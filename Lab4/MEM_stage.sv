`timescale 1ns/10ps
module MEM_stage (input logic clk,
						input logic [3:0] 	LDURBsel,
						input logic [63:0] 	ALUout, Db,
						input logic 			MemToReg, wrByte, load, MemWrite,
						output logic [63:0] 	wrBout);
	
	logic [63:0] Memout, Memout2, byteResult;
	assign byteResult = {56'b0, Memout2[7:0]};
	
	genvar i;
	generate
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 MemOutSel (.selector(MemToReg), .in({Memout[i], ALUout[i]}), .out(Memout2[i]));
		mux2x1 WrByteMUX (.selector(wrByte), .in({byteResult[i], Memout2[i]}), .out(wrBout[i]));
	end
	endgenerate
	
	datamem memory(.address(ALUout), .write_enable(MemWrite), .read_enable(load), .write_data(Db), .clk,
						.xfer_size(LDURBsel), .read_data(Memout));

endmodule
