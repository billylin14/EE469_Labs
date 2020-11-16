//wrEn = regWE
module pipeline_registers(
						input logic wrEn, clk, reset,
						input logic inUncondBr, inBrTaken, //control signals to PCIncrementor
						input logic inReg2Loc, inRegWrite, inMemWrite, inwrByte, inMemToReg, inimmSel, inALUsrc, inKZsel, inMOVsel, insetFlag, inload,//control signals to datapath
						input logic [4:0] 	inRn, inRm, inRd, //register
						input logic [2:0] 	inALUop,
						input logic [11:0] 	inimm12,
						input logic [15:0] 	inimm16,
						input logic [8:0]		inDAddr9,
						input logic [18:0] 	inCondAddr19,
						input logic [25:0] 	inBrAddr26,
						input logic [3:0]		inLDURBsel,
						input logic [1:0] 	inSHAMT,
						output logic outUncondBr, outBrTaken, //control signals to PCIncrementor
						output logic outReg2Loc, outRegWrite, outMemWrite, outwrByte, outMemToReg, outimmSel, outALUsrc, outKZsel, outMOVsel, outsetFlag, outload,//control signals to datapath
						output logic [4:0] 	outRn, outRm, outRd, //register
						output logic [2:0] 	outALUop,
						output logic [11:0] 	outimm12,
						output logic [15:0] 	outimm16,
						output logic [8:0]	outDAddr9,
						output logic [18:0] 	outCondAddr19,
						output logic [25:0] 	outBrAddr26,
						output logic [3:0]	outLDURBsel,
						output logic [1:0] 	outSHAMT);
						
	register uncondBr 	#(1) 	(.wrData(inUncondBr), 	.dOut(outUncondBr), .reset, .clk, .wrEn);
	register brTaken 		#(1) 	(.wrData(inBrTaken), 	.dOut(outBrTaken), .reset, .clk, .wrEn);
	register Reg2Loc 		#(1) 	(.wrData(inReg2Loc), 	.dOut(outReg2Loc), .reset, .clk, .wrEn);
	register RegWrite 	#(1) 	(.wrData(inRegWrite), 	.dOut(outRegWrite), .reset, .clk, .wrEn);
	register MemWrite 	#(1) 	(.wrData(inMemWrite), 	.dOut(outMemWrite), .reset, .clk, .wrEn);
	register wrByte 		#(1) 	(.wrData(inwrByte), 		.dOut(outwrByte), .reset, .clk, .wrEn);
	register MemToReg 	#(1) 	(.wrData(inMemToReg), 	.dOut(outMemToReg), .reset, .clk, .wrEn);
	register immSel 		#(1) 	(.wrData(inimmSel), 		.dOut(outimmSel), .reset, .clk, .wrEn);
	register ALUsrc 		#(1) 	(.wrData(inALUsrc), 		.dOut(outALUsrc), .reset, .clk, .wrEn);
	register KZsel 		#(1) 	(.wrData(inKZsel), 		.dOut(outKZsel), .reset, .clk, .wrEn);
	register MOVsel 		#(1) 	(.wrData(inMOVsel), 		.dOut(outMOVsel), .reset, .clk, .wrEn);
	register setFlag 		#(1) 	(.wrData(insetFlag), 	.dOut(outsetFlag), .reset, .clk, .wrEn);
	register load 			#(1) 	(.wrData(inload), 		.dOut(outload), .reset, .clk, .wrEn);

	
	register Rn 			#(5) 	(.wrData(inRn), 			.dOut(outRn), .reset, .clk, .wrEn);
	register Rm 			#(5) 	(.wrData(inRm), 			.dOut(outRm), .reset, .clk, .wrEn);
	register Rd 			#(5) 	(.wrData(inRd), 			.dOut(outRd), .reset, .clk, .wrEn);
	register ALUop 		#(3) 	(.wrData(inALUop), 		.dOut(outALUop), .reset, .clk, .wrEn);
	
	//constants
	register imm12 		#(12) (.wrData(inimm12), 		.dOut(outimm12), .reset, .clk, .wrEn);
	register imm16 		#(16) (.wrData(inimm16), 		.dOut(outimm16), .reset, .clk, .wrEn);
	register DAddr9		#(9) 	(.wrData(inDAddr9), 		.dOut(outDAddr9), .reset, .clk, .wrEn);
	register CondAddr19	#(19) (.wrData(inCondAddr19), .dOut(outCondAddr19), .reset, .clk, .wrEn);
	register BrAddr26		#(26) (.wrData(inBrAddr26), 	.dOut(outBrAddr26), .reset, .clk, .wrEn);
	register LDURBsel 	#(4) 	(.wrData(inLDURBsel), 	.dOut(outLDURBsel), .reset, .clk, .wrEn);
	register SHAMT 		#(2) 	(.wrData(inSHAMT), 		.dOut(outSHAMT), .reset, .clk, .wrEn);
	