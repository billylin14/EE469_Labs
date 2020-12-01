//wrEn = regWE
module pipeline_registers(
						input logic wrEn, clk, reset,
						//INPUT control signals to PCIncrementor
						input logic inUncondBr, inBrTaken, 
						//INPUT control signals to datapath
						input logic inReg2Loc, inRegWrite, inMemWrite, inwrByte, inMemToReg, inimmSel, inALUsrc, inKZsel, inMOVsel, insetFlag, inload,//control signals to datapath
						//INPUT registers
						input logic [4:0] 	inRn, inRm, inRd, 
						input logic [2:0] 	inALUop,
						input logic [4:0]		inAa, inAb, inAw,
						//INPUT data (after RF) 
						//**CONCERN: THE OUTPUT WILL NOT bE WRITTEN TO RF UNTIL WR STAGE. HOWEVER, WE DO HAVE THE DATA READY IN THE INTERMEDIATE LOGICS
						input logic [63:0] 	inDa, inDb, inALUin, inimm, inKZin,
						//INPUT data (after EX)
						input logic [63:0]	inALUout,
						//INPUT data (after MEM)
						input logic [63:0]	inMemout, inMemout2, inwrBout, inDw, inMOVout, byteResult,
						//INPUT immediates
						input logic [11:0] 	inimm12, inimm12_pad, 
						input logic [15:0] 	inimm16,
						input logic [8:0]		inDAddr9, inDAddr9_SE, 
						input logic [18:0] 	inCondAddr19,
						input logic [25:0] 	inBrAddr26,
						input logic [3:0]		inLDURBsel,
						input logic [1:0] 	inSHAMT,
						
						//OUTPUT control signals to PCIncrementor
						output logic outUncondBr, outBrTaken,
						//OUTPUT control signals to datapath
						output logic outReg2Loc, outRegWrite, outMemWrite, outwrByte, outMemToReg, outimmSel, outALUsrc, outKZsel, outMOVsel, outsetFlag, outload,//control signals to datapath
						//OUTPUT registers
						output logic [4:0] 	outRn, outRm, outRd, 
						output logic [2:0] 	outALUop,
						output logic [4:0]	outAa, outAb, outAw,
						//OUTPUT data (after RF) 
						//**CONCERN: THE OUTPUT WILL NOT bE WRITTEN TO RF UNTIL WR STAGE. HOWEVER, WE DO HAVE THE DATA READY IN THE INTERMEDIATE LOGICS
						output logic [63:0] 	outDa, outDb, outALUin, outimm, outKZin,
						//OUTPUT data (after EX)
						output logic [63:0]	outALUout,
						//OUTPUT data (after MEM)
						output logic [63:0]	outMemout, inMemout2, inwrBout, inDw, inMOVout, byteResult,
						//OUTPUT immediates
						output logic [11:0] 	outimm12, outimm12_pad,
						output logic [15:0] 	outimm16,
						output logic [8:0]	outDAddr9, outDAddr9_SE,
						output logic [18:0] 	outCondAddr19,
						output logic [25:0] 	outBrAddr26,
						output logic [3:0]	outLDURBsel,
						output logic [1:0] 	outSHAMT);
						
<<<<<<< HEAD
	logic [63:0]  
					 byteResult,
	             imm12_pad, //ADDI path
	             DAddr9_SE, //LDUR(B), STUR(B) path
					 imm,			//output from immSelector into ALUSrCSel
					 KZin;
	logic [3:0] shiftSHAMT;
	
	//CONTROL SIGNALS					
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

	//REGISTERS
	register Rn 			#(5) 	(.wrData(inRn), 			.dOut(outRn), .reset, .clk, .wrEn);
	register Rm 			#(5) 	(.wrData(inRm), 			.dOut(outRm), .reset, .clk, .wrEn);
	register Rd 			#(5) 	(.wrData(inRd), 			.dOut(outRd), .reset, .clk, .wrEn);
	register ALUop 		#(3) 	(.wrData(inALUop), 		.dOut(outALUop), .reset, .clk, .wrEn);
	register Aa		 		#(5) 	(.wrData(inAa), 			.dOut(outAa), .reset, .clk, .wrEn);
	register Ab		 		#(5) 	(.wrData(inAb), 			.dOut(outAb), .reset, .clk, .wrEn);
	register Aw		 		#(5) 	(.wrData(inAw), 			.dOut(outAw), .reset, .clk, .wrEn);
	
	//DATA
	register Da 			#(64) 	(.wrData(inDa), 			.dOut(outDa), .reset, .clk, .wrEn);
	register Db 			#(64) 	(.wrData(inDb), 			.dOut(outDb), .reset, .clk, .wrEn);
	register ALUin			#(64) 	(.wrData(inALUin), 		.dOut(outALUin), .reset, .clk, .wrEn);
	register imm	 		#(64) 	(.wrData(inimm), 			.dOut(outimm), .reset, .clk, .wrEn);
	register KZin 			#(64) 	(.wrData(inKZin), 		.dOut(outKZin), .reset, .clk, .wrEn);
	register ALUout		#(64) 	(.wrData(inALUout), 		.dOut(outALUout), .reset, .clk, .wrEn);
	register Memout		#(64) 	(.wrData(inMemout), 		.dOut(outMemout), .reset, .clk, .wrEn);
	register Memout2 		#(64) 	(.wrData(inMemout2), 	.dOut(outMemout2), .reset, .clk, .wrEn);
	register wrBout		#(64) 	(.wrData(inwrBout), 		.dOut(outwrBout), .reset, .clk, .wrEn);
	register Dw 			#(64) 	(.wrData(inDw), 			.dOut(outDw), .reset, .clk, .wrEn);
	register MOVout		#(64) 	(.wrData(inMOVout), 		.dOut(outMOVout), .reset, .clk, .wrEn);
	register byteResult	#(64) 	(.wrData(inbyteResult), .dOut(outbyteResult), .reset, .clk, .wrEn);
	register imm12_pad	#(64) 	(.wrData(inimm12_pad),	.dOut(outimm12_pad), .reset, .clk, .wrEn);
	register DAddr9_SE 	#(64) 	(.wrData(inDAddr9_SE), 	.dOut(outDAddr9_SE), .reset, .clk, .wrEn);

	//IMMEDIATES
	register imm12 		#(12) (.wrData(inimm12), 		.dOut(outimm12), .reset, .clk, .wrEn);
	register imm16 		#(16) (.wrData(inimm16), 		.dOut(outimm16), .reset, .clk, .wrEn);
	register DAddr9		#(9) 	(.wrData(inDAddr9), 		.dOut(outDAddr9), .reset, .clk, .wrEn);
	register CondAddr19	#(19) (.wrData(inCondAddr19), .dOut(outCondAddr19), .reset, .clk, .wrEn);
	register BrAddr26		#(26) (.wrData(inBrAddr26), 	.dOut(outBrAddr26), .reset, .clk, .wrEn);
	register LDURBsel 	#(4) 	(.wrData(inLDURBsel), 	.dOut(outLDURBsel), .reset, .clk, .wrEn);
	register SHAMT 		#(2) 	(.wrData(inSHAMT), 		.dOut(outSHAMT), .reset, .clk, .wrEn);
	
=======
	register #(1) uncondBr		(.wrData(inUncondBr), 	.dOut(outUncondBr), .reset, .clk, .wrEn);
	register #(1) brTaken 		(.wrData(inBrTaken), 	.dOut(outBrTaken), .reset, .clk, .wrEn);
	register #(1) Reg2Loc 	 	(.wrData(inReg2Loc), 	.dOut(outReg2Loc), .reset, .clk, .wrEn);
	register #(1) RegWrite 	 	(.wrData(inRegWrite), 	.dOut(outRegWrite), .reset, .clk, .wrEn);
	register #(1) MemWrite 	 	(.wrData(inMemWrite), 	.dOut(outMemWrite), .reset, .clk, .wrEn);
	register #(1) wrByte 		(.wrData(inwrByte), 		.dOut(outwrByte), .reset, .clk, .wrEn);
	register #(1) MemToReg 	 	(.wrData(inMemToReg), 	.dOut(outMemToReg), .reset, .clk, .wrEn);
	register #(1) immSel 	 	(.wrData(inimmSel), 		.dOut(outimmSel), .reset, .clk, .wrEn);
	register #(1) ALUsrc 	 	(.wrData(inALUsrc), 		.dOut(outALUsrc), .reset, .clk, .wrEn);
	register #(1) KZsel 			(.wrData(inKZsel), 		.dOut(outKZsel), .reset, .clk, .wrEn);
	register #(1) MOVsel 		(.wrData(inMOVsel), 		.dOut(outMOVsel), .reset, .clk, .wrEn);
	register #(1) setFlag 	 	(.wrData(insetFlag), 	.dOut(outsetFlag), .reset, .clk, .wrEn);
	register #(1) load 		 	(.wrData(inload), 		.dOut(outload), .reset, .clk, .wrEn);

	
	register #(5)Rn 			 	(.wrData(inRn), 			.dOut(outRn), .reset, .clk, .wrEn);
	register #(5)Rm 			 	(.wrData(inRm), 			.dOut(outRm), .reset, .clk, .wrEn);
	register #(5)Rd 			 	(.wrData(inRd), 			.dOut(outRd), .reset, .clk, .wrEn);
	register #(3)ALUop 	 		(.wrData(inALUop), 		.dOut(outALUop), .reset, .clk, .wrEn);
		
	//constants
	register #(12) imm12 		(.wrData(inimm12), 		.dOut(outimm12), .reset, .clk, .wrEn);
	register #(16) imm16 		(.wrData(inimm16), 		.dOut(outimm16), .reset, .clk, .wrEn);
	register #(9)  DAddr9		(.wrData(inDAddr9), 		.dOut(outDAddr9), .reset, .clk, .wrEn);
	register #(19) CondAddr19	(.wrData(inCondAddr19), .dOut(outCondAddr19), .reset, .clk, .wrEn);
	register #(26) BrAddr26		(.wrData(inBrAddr26), 	.dOut(outBrAddr26), .reset, .clk, .wrEn);
	register #(4)  LDURBsel 	(.wrData(inLDURBsel), 	.dOut(outLDURBsel), .reset, .clk, .wrEn);
	register #(2)  SHAMT 		(.wrData(inSHAMT), 		.dOut(outSHAMT), .reset, .clk, .wrEn);
endmodule	
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309
