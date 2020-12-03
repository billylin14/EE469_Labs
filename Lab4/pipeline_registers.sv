//wrEn = regWE
module pipeline_registers(
	input logic 			clk, reset, wrEn,
	input logic 			inUncondBr, inBrTaken, //control signals to PCIncrementor
	input logic [63:0]	inPC,
	input logic 			inReg2Loc, inRegWrite, inMemWrite, inwrByte, inMemToReg, inimmSel, inALUsrc, inKZsel, inMOVsel, insetFlag, inload,//control signals to datapath
	input logic [4:0] 	inRn, inRm, inRd, //register
	input logic [2:0] 	inALUop,
	
	input logic [11:0] 	inimm12,
	input logic [15:0] 	inimm16,
	input logic [8:0]		inDAddr9,
	input logic [18:0] 	inCondAddr19,
	input logic [25:0] 	inBrAddr26,
	input logic [3:0]		inLDURBsel,
	input logic [1:0] 	inSHAMT,
	
	input logic [63:0]	inDw, 		
	input logic [63:0] 	inDa, inALUin, inDb,
	input logic [63:0] 	inMOVout, inwrBout,
	input logic [63:0] 	inALUout,
	
	input logic 			innegative, inzero, inoverflow, incarry_out, incbzFlag,
	
	
	output logic 			outUncondBr, outBrTaken, //control signals to PCIncrementor
	output logic [63:0]	outPC,
	output logic 			outReg2Loc, outRegWrite, outMemWrite, outwrByte, outMemToReg, outimmSel, outALUsrc, outKZsel, outMOVsel, outsetFlag, outload,//control signals to datapath
	output logic [4:0] 	outRn, outRm, outRd, //register
	output logic [2:0] 	outALUop,
	
	output logic [11:0] 	outimm12,
	output logic [15:0] 	outimm16,
	output logic [8:0]	outDAddr9,
	output logic [18:0] 	outCondAddr19,
	output logic [25:0] 	outBrAddr26,
	output logic [3:0]	outLDURBsel,
	output logic [1:0] 	outSHAMT,
	
	output logic [63:0]	outDw, 		
	output logic [63:0] 	outDa, outALUin, outDb,
	output logic [63:0] 	outMOVout, outwrBout,
	output logic [63:0] 	outALUout,
	
	output logic 			outnegative, outzero, outoverflow, outcarry_out, outcbzFlag);
	
	//PC
	register  #(64) PC	(.wrData(inPC), .dOut(outPC), .reset, .clk, .wrEn);
	//CONTROL SIGNALS					
	register  #(1) uncondBr	(.wrData(inUncondBr), 	.dOut(outUncondBr), .reset, .clk, .wrEn);
	register  #(1) brTaken	(.wrData(inBrTaken), 	.dOut(outBrTaken), .reset, .clk, .wrEn);
	register  #(1) Reg2Loc	(.wrData(inReg2Loc), 	.dOut(outReg2Loc), .reset, .clk, .wrEn);
	register  #(1) RegWrite(.wrData(inRegWrite), 	.dOut(outRegWrite), .reset, .clk, .wrEn);
	register  #(1) MemWrite(.wrData(inMemWrite), 	.dOut(outMemWrite), .reset, .clk, .wrEn);
	register  #(1) wrByte	(.wrData(inwrByte), 		.dOut(outwrByte), .reset, .clk, .wrEn);
	register  #(1) MemToReg	(.wrData(inMemToReg), 	.dOut(outMemToReg), .reset, .clk, .wrEn);
	register  #(1) immSel	(.wrData(inimmSel), 		.dOut(outimmSel), .reset, .clk, .wrEn);
	register  #(1) ALUsrc	(.wrData(inALUsrc), 		.dOut(outALUsrc), .reset, .clk, .wrEn);
	register  #(1) KZsel	(.wrData(inKZsel), 		.dOut(outKZsel), .reset, .clk, .wrEn);
	register  #(1) MOVsel	(.wrData(inMOVsel), 		.dOut(outMOVsel), .reset, .clk, .wrEn);
	register  #(1) setFlag	(.wrData(insetFlag), 	.dOut(outsetFlag), .reset, .clk, .wrEn);
	register  #(1) load	(.wrData(inload), 		.dOut(outload), .reset, .clk, .wrEn);

	//REGISTERS
	register  #(5) Rn		(.wrData(inRn), 			.dOut(outRn), .reset, .clk, .wrEn);
	register  #(5) Rm		(.wrData(inRm), 			.dOut(outRm), .reset, .clk, .wrEn);
	register  #(5) Rd		(.wrData(inRd), 			.dOut(outRd), .reset, .clk, .wrEn);
	register  #(3) ALUop	(.wrData(inALUop), 		.dOut(outALUop), .reset, .clk, .wrEn);
	
	//IMMEDIATES
	register  #(12) imm12 		(.wrData(inimm12), 		.dOut(outimm12), .reset, .clk, .wrEn);
	register  #(16) imm16 		(.wrData(inimm16), 		.dOut(outimm16), .reset, .clk, .wrEn);
	register  #(9)  DAddr9		(.wrData(inDAddr9), 		.dOut(outDAddr9), .reset, .clk, .wrEn);
	register  #(19) CondAddr19	(.wrData(inCondAddr19), .dOut(outCondAddr19), .reset, .clk, .wrEn);
	register  #(26) BrAddr26 	(.wrData(inBrAddr26), 	.dOut(outBrAddr26), .reset, .clk, .wrEn);
	register  #(4)  LDURBsel	(.wrData(inLDURBsel), 	.dOut(outLDURBsel), .reset, .clk, .wrEn);
	register  #(2)  SHAMT		(.wrData(inSHAMT), 		.dOut(outSHAMT), .reset, .clk, .wrEn);
	
	//DATA
	register  #(64) DW		(.wrData(inDw), 			.dOut(outDw), .reset, .clk, .wrEn);
	register  #(64) Da 		(.wrData(inDa), 			.dOut(outDa), .reset, .clk, .wrEn);
	register  #(64) ALUin	(.wrData(inALUin), 		.dOut(outALUin), .reset, .clk, .wrEn);
	register  #(64) Db 		(.wrData(inDb), 			.dOut(outDb), .reset, .clk, .wrEn);
	register  #(64) MOVout	(.wrData(inMOVout), 		.dOut(outMOVout), .reset, .clk, .wrEn);
	register  #(64) wrBout	(.wrData(inwrBout), 		.dOut(outwrBout), .reset, .clk, .wrEn);
	register  #(64) ALUout	(.wrData(inALUout), 		.dOut(outALUout), .reset, .clk, .wrEn);
	
	//FLAGS
	register  #(1) negative (.wrData(innegative), 	.dOut(outnegative), .reset, .clk, .wrEn);
	register  #(1)	zero 		(.wrData(inzero), 		.dOut(outzero), .reset, .clk, .wrEn);
	register  #(1) overflow (.wrData(inoverflow), 	.dOut(outoverflow), .reset, .clk, .wrEn);
	register  #(1) carry_out(.wrData(incarry_out), 	.dOut(outcarry_out), .reset, .clk, .wrEn);
	register  #(1) cbzFlag 	(.wrData(incbzFlag), 	.dOut(outcbzFlag), .reset, .clk, .wrEn);
	
endmodule	
