// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 CameronCPU.sv

// Input with a clock and a reset signal,
// Performs the specified instruction set from the instruction memory (instrmem) and
// Acts as a single cycle CPU that performs one instruction in a cycle


//PLAN:
//1. make pipeline working without adding any extra hardware
// **check if structural hazard (padding stages) exists in our implementation**
//2. invert the clock signal for regfile
//3. add accelerate branches
//4. add forwarding unit
//5. **not sure about the delay slots (do NOOP? switch order of instruction??)
//**in the pipeline_registers, we might not need to store every logic


`timescale 1ns/10ps
module CameronCPU (input logic clk, reset);
	
		// IF variables
	logic 			UncondBr;
	logic [1:0]		BrSel; //control signals to PCIncrementor
	logic [63:0]	PC;
	logic 			Reg2Loc, RegWrite, MemWrite, wrByte, MemToReg, immSel, ALUsrc, KZsel, MOVsel, setFlag, load;//control signals to datapath
	logic [4:0] 	Rn, Rm, Rd; //register
	logic [2:0] 	ALUop;
	
	logic [11:0] 	imm12;
	logic [15:0] 	imm16;
	logic [8:0]		DAddr9;
	logic [18:0] 	CondAddr19;
	logic [25:0] 	BrAddr26;
	logic [3:0]		LDURBsel;
	logic [1:0] 	SHAMT;
	
	logic [63:0]	Dw; 		
	logic [63:0] 	Da, ALUin, Db;
	logic [63:0] 	MOVout, wrBout;
	logic [63:0] 	ALUout;
	logic [63:0]	PCout;
	
	logic 			negative, zero, overflow, carry_out, cbzFlag;
	
	// RF Variables
	logic 			UncondBrRF; 
	logic [1:0]		BrSelRF; //control signals to PCIncrementor
	logic [63:0]	PCRF;
	logic 			Reg2LocRF, RegWriteRF, MemWriteRF, wrByteRF, MemToRegRF, immSelRF, ALUsrcRF, KZselRF, MOVselRF, setFlagRF, loadRF;//control signals to datapath
	logic [4:0] 	RnRF, RmRF, RdRF; //register
	logic [2:0] 	ALUopRF;
	
	logic [11:0] 	imm12RF;
	logic [15:0] 	imm16RF;
	logic [8:0]		DAddr9RF;
	logic [18:0] 	CondAddr19RF;
	logic [25:0] 	BrAddr26RF;
	logic [3:0]		LDURBselRF;
	logic [1:0] 	SHAMTRF;
	
	logic [63:0]	DwRF;	
	logic [63:0] 	DaRF, ALUinRF, DbRF;
	logic [63:0] 	MOVoutRF, wrBoutRF;
	logic [63:0] 	ALUoutRF;
	
	logic 			negativeRF, zeroRF, overflowRF, carry_outRF, cbzFlagRF;
	
	// EX Variables
	logic 			UncondBrEX; //control signals to PCIncrementor
	logic 			Reg2LocEX, RegWriteEX, MemWriteEX, wrByteEX, MemToRegEX, immSelEX, ALUsrcEX, KZselEX, MOVselEX, setFlagEX, loadEX;//control signals to datapath
	logic [4:0] 	RnEX, RmEX, RdEX; //register
	logic [2:0] 	ALUopEX;
	
	logic [11:0] 	imm12EX;
	logic [15:0] 	imm16EX;
	logic [8:0]		DAddr9EX;
	logic [18:0] 	CondAddr19EX;
	logic [25:0] 	BrAddr26EX;
	logic [3:0]		LDURBselEX;
	logic [1:0] 	SHAMTEX;
	
	logic [63:0]	DwEX;	
	logic [63:0] 	DaEX, ALUinEX, DbEX;
	logic [63:0] 	MOVoutEX, wrBoutEX;
	logic [63:0] 	ALUoutEX;
	
	logic 			negativeEX, zeroEX, overflowEX, carry_outEX, cbzFlagEX;
	
	// MEM Variables
	logic 			UncondBrMEM; //control signals to PCIncrementor
	logic 			Reg2LocMEM, RegWriteMEM, MemWriteMEM, wrByteMEM, MemToRegMEM, immSelMEM, ALUsrcMEM, KZselMEM, MOVselMEM, setFlagMEM, loadMEM;//control signals to datapath
	logic [4:0] 	RnMEM, RmMEM, RdMEM; //register
	logic [2:0] 	ALUopMEM;
	
	logic [11:0] 	imm12MEM;
	logic [15:0] 	imm16MEM;
	logic [8:0]		DAddr9MEM;
	logic [18:0] 	CondAddr19MEM;
	logic [25:0] 	BrAddr26MEM;
	logic [3:0]		LDURBselMEM;
	logic [1:0] 	SHAMTMEM;
	
	logic [63:0]	DwMEM;	
	logic [63:0] 	DaMEM, ALUinMEM, DbMEM;
	logic [63:0] 	MOVoutMEM, wrBoutMEM;
	logic [63:0] 	ALUoutMEM;
	
	logic 			negativeMEM, zeroMEM, overflowMEM, carry_outMEM, cbzFlagMEM;
	
	// WB Variables
	logic 			UncondBrWB; //control signals to PCIncrementor
	logic 			Reg2LocWB, RegWriteWB, MemWriteWB, wrByteWB, MemToRegWB, immSelWB, ALUsrcWB, KZselWB, MOVselWB, setFlagWB, loadWB;//control signals to datapath
	logic [4:0] 	RnWB, RmWB, RdWB; //register
	logic [2:0] 	ALUopWB;
	
	logic [11:0] 	imm12WB;
	logic [15:0] 	imm16WB;
	logic [8:0]		DAddr9WB;
	logic [18:0] 	CondAddr19WB;
	logic [25:0] 	BrAddr26WB;
	logic [3:0]		LDURBselWB;
	logic [1:0] 	SHAMTWB;
	
	logic [63:0]	DwWB;	
	logic [63:0] 	DaWB, ALUinWB, DbWB;
	logic [63:0] 	MOVoutWB, wrBoutWB;
	logic [63:0] 	ALUoutWB;
	
	logic 			negativeWB, zeroWB, overflowWB, carry_outWB, cbzFlagWB;
	
	//IF- Instruction Fetch	
	IF_stage ifStage (.clk, .reset, //input
							.negativeFlag(negativeEX), .cbzFlag(cbzFlag),
							.UncondBrRF, .BrSelRF,
							.PCRF,
							.CondAddr19RF,
							.BrAddr26RF,
							
							.UncondBr, .BrSel, //control signals to PCIncrementor
							.Reg2Loc, .RegWrite, .MemWrite, .wrByte, .MemToReg, .immSel, .ALUsrc, .KZsel, .MOVsel, .setFlag, .load,//control signals to datapath
							.Rn, .Rm, .Rd, //register
							.ALUop,
							.imm12,
							.imm16,
							.DAddr9,
							.CondAddr19,	
							.BrAddr26,		
							.LDURBsel,
							.SHAMT,
							.PCout);
	
	pipeline_registers IF2RF(	.clk, .reset, .wrEn(1'b1),
										.inUncondBr(UncondBr), .inBrSel(BrSel), //control signals to PCIncrementor
										.inPC(PCout),
										.inReg2Loc(Reg2Loc), .inRegWrite(RegWrite), .inMemWrite(MemWrite), .inwrByte(wrByte), .inMemToReg(MemToReg), .inimmSel(immSel), .inALUsrc(ALUsrc), .inKZsel(KZsel), .inMOVsel(MOVsel), .insetFlag(setFlag), .inload(load),//control signals to datapath
										.inRn(Rn), .inRm(Rm), .inRd(Rd), //register
										.inALUop(ALUop),
										.inimm12(imm12),
										.inimm16(imm16),
										.inDAddr9(DAddr9),
										.inCondAddr19(CondAddr19),
										.inBrAddr26(BrAddr26),
										.inLDURBsel(LDURBsel),
										.inSHAMT(SHAMT),
										.inDw(), 		
										.inDa(), .inALUin(), .inDb(),
										.inMOVout(), .inwrBout(),
										.inALUout(),
										.innegative(), .inzero(), .inoverflow(), .incarry_out(), .incbzFlag(),
										
										.outUncondBr(UncondBrRF), .outBrSel(BrSelRF), //control signals to PCincrementor
										.outPC(PCRF),
										.outReg2Loc(Reg2LocRF), .outRegWrite(RegWriteRF), .outMemWrite(MemWriteRF), .outwrByte(wrByteRF), .outMemToReg(MemToRegRF), .outimmSel(immSelRF), .outALUsrc(ALUsrcRF), .outKZsel(KZselRF), .outMOVsel(MOVselRF), .outsetFlag(setFlagRF), .outload(loadRF),//control signals to datapath
										.outRn(RnRF), .outRm(RmRF), .outRd(RdRF), //register
										.outALUop(ALUopRF),
										.outimm12(imm12RF),
										.outimm16(imm16RF),
										.outDAddr9(DAddr9RF),
										.outCondAddr19(CondAddr19RF),
										.outBrAddr26(BrAddr26RF),
										.outLDURBsel(LDURBselRF),
										.outSHAMT(SHAMTRF),
										.outDw(), 		
										.outDa(), .outALUin(), .outDb(),
										.outMOVout(), .outwrBout(),
										.outALUout(),
										.outnegative(), .outzero(), .outoverflow(), .outcarry_out(), .outcbzFlag());

	
	//RF- Register Fetch
	logic cbzFlagTemp;
	norGate64x1 norgate (.in(DaRF), .out(cbzFlag));
	
	RF_stage rfStage	(.clk, //invert this
							 .Reg2Loc(Reg2LocRF), .immSel(immSelRF), .ALUsrc(ALUsrcRF), .setFlag(setFlagRF),//control signals to datapath
							 .Rn(RnRF), .Rm(RmRF), .Rd(RdRF), //register
							 .imm12(imm12RF),
							 .DAddr9(DAddr9RF),
							 .AwWB(RdWB),				//from WB stage to write
							 .Dw(DwWB), 		 		//from WB stage mux
							 .RegWrite(RegWriteWB), //from WB
							 .DwMEM(wrBoutMEM), .ALUoutEX(ALUoutEX),	//for forwarding, from EX and MEM
							 .AwEX(RdEX), .AwMEM(RdMEM),
							 .Da(DaRF), .ALUin(ALUinRF), .Db(DbRF));
	
	pipeline_registers RF2EX(	.clk, .reset, .wrEn(1'b1),
										.inUncondBr(UncondBrRF), .inBrSel(BrSelRF), //control signals to PCincrementor
										.inPC(),
										.inReg2Loc(), .inRegWrite(RegWriteRF), .inMemWrite(MemWriteRF), .inwrByte(wrByteRF), .inMemToReg(MemToRegRF), .inimmSel(), .inALUsrc(), .inKZsel(KZselRF), .inMOVsel(MOVselRF), .insetFlag(setFlagRF), .inload(loadRF),//control signals to datapath
										.inRn(RnRF), .inRm(RmRF), .inRd(RdRF), //register
										.inALUop(ALUopRF),
										.inimm12(imm12RF),
										.inimm16(imm16RF),
										.inDAddr9(DAddr9RF),
										.inCondAddr19(CondAddr19RF),
										.inBrAddr26(BrAddr26RF),
										.inLDURBsel(LDURBselRF),
										.inSHAMT(SHAMTRF),
										.inDw(), 		
										.inDa(DaRF), .inALUin(ALUinRF), .inDb(DbRF),
										.inMOVout(), .inwrBout(),
										.inALUout(),
										.innegative(), .inzero(), .inoverflow(), .incarry_out(), .incbzFlag(),
										
										.outUncondBr(UncondBrEX), .outBrSel(), //control signals to PCincrementor
										.outPC(),
										.outReg2Loc(), .outRegWrite(RegWriteEX), .outMemWrite(MemWriteEX), .outwrByte(wrByteEX), .outMemToReg(MemToRegEX), .outimmSel(), .outALUsrc(), .outKZsel(KZselEX), .outMOVsel(MOVselEX), .outsetFlag(setFlagEX), .outload(loadEX),//control signals to datapath
										.outRn(RnEX), .outRm(RmEX), .outRd(RdEX), //register
										.outALUop(ALUopEX),
										.outimm12(imm12EX),
										.outimm16(imm16EX),
										.outDAddr9(DAddr9EX),
										.outCondAddr19(CondAddr19EX),
										.outBrAddr26(BrAddr26EX),
										.outLDURBsel(LDURBselEX),
										.outSHAMT(SHAMTEX),
										.outDw(), 		
										.outDa(DaEX), .outALUin(ALUinEX), .outDb(DbEX),
										.outMOVout(), .outwrBout(),
										.outALUout(),
										.outnegative(), .outzero(), .outoverflow(), .outcarry_out(), .outcbzFlag());
	
	//EX- Execute
	//TODO:	1. include MOVZ/MOVK here
	
	EX_stage exStage (.clk,
							.Da(DaEX), .Db(DbEX), .ALUin(ALUinEX),
							.SHAMT(SHAMTEX),
							.setFlag(setFlagEX), .KZsel(KZselEX), .MOVsel(MOVselEX),
							.ALUop(ALUopEX),
							.imm16(imm16EX),
							.ALUout(ALUoutEX), .MOVout(MOVoutEX),
							.negative(negativeEX), .zero(zeroEX), .overflow(overflowEX), .carry_out(carry_outEX), .cbzFlag());
		
	pipeline_registers EX2MEM( .clk, .reset, .wrEn(1'b1),
										.inUncondBr(), .inBrSel(), //control signals to PCincrementor
										.inPC(),
										.inReg2Loc(), .inRegWrite(RegWriteEX), .inMemWrite(MemWriteEX), .inwrByte(wrByteEX), .inMemToReg(MemToRegEX), .inimmSel(), .inALUsrc(), .inKZsel(), .inMOVsel(MOVselEX), .insetFlag(), .inload(loadEX),//control signals to datapath
										.inRn(RnEX), .inRm(RmEX), .inRd(RdEX), //register
										.inALUop(),
										.inimm12(),
										.inimm16(),
										.inDAddr9(),
										.inCondAddr19(CondAddr19EX),
										.inBrAddr26(),
										.inLDURBsel(LDURBselEX),
										.inSHAMT(),
										.inDw(), 		
										.inDa(), .inALUin(), .inDb(DbEX),
										.inMOVout(MOVoutEX), .inwrBout(),
										.inALUout(ALUoutEX),
										.innegative(negativeEX), .inzero(zeroEX), .inoverflow(overflowEX), .incarry_out(carry_outEX), .incbzFlag(),
										
										.outUncondBr(UncondBrMEM), .outBrSel(), //control signals to PCincrementor
										.outPC(),
										.outReg2Loc(), .outRegWrite(RegWriteMEM), .outMemWrite(MemWriteMEM), .outwrByte(wrByteMEM), .outMemToReg(MemToRegMEM), .outimmSel(), .outALUsrc(), .outKZsel(), .outMOVsel(MOVselMEM), .outsetFlag(), .outload(loadMEM),//control signals to datapath
										.outRn(RnMEM), .outRm(RmMEM), .outRd(RdMEM), //register
										.outALUop(),
										.outimm12(),
										.outimm16(),
										.outDAddr9(),
										.outCondAddr19(CondAddr19MEM),
										.outBrAddr26(),
										.outLDURBsel(LDURBselMEM),
										.outSHAMT(),
										.outDw(), 		
										.outDa(), .outALUin(), .outDb(DbMEM),
										.outMOVout(MOVoutMEM), .outwrBout(),
										.outALUout(ALUoutMEM),
										.outnegative(negativeMEM), .outzero(zeroMEM), .outoverflow(overflowMEM), .outcarry_out(carry_outMEM), .outcbzFlag());
	
	//MEM- Data Memory

	MEM_stage memStage  (.clk,
								.LDURBsel(LDURBselMEM),
								.ALUout(ALUoutMEM), .Db(DbMEM),
								.MemToReg(MemToRegMEM), .wrByte(wrByteMEM), .load(loadMEM), .MemWrite(MemWriteMEM),
								.wrBout(wrBoutMEM));
						
	pipeline_registers MEM2WB( .clk, .reset, .wrEn(1'b1),
										.inUncondBr(), .inBrSel(), //control signals to PCincrementor
										.inPC(),
										.inReg2Loc(), .inRegWrite(RegWriteMEM), .inMemWrite(), .inwrByte(), .inMemToReg(), .inimmSel(), .inALUsrc(), .inKZsel(), .inMOVsel(MOVselMEM), .insetFlag(), .inload(),//control signals to datapath
										.inRn(RnMEM), .inRm(RmMEM), .inRd(RdMEM), //register
										.inALUop(),
										.inimm12(),
										.inimm16(),
										.inDAddr9(),
										.inCondAddr19(),
										.inBrAddr26(),
										.inLDURBsel(),
										.inSHAMT(),
										.inDw(DwMEM), 		
										.inDa(), .inALUin(), .inDb(),
										.inMOVout(MOVoutMEM), .inwrBout(wrBoutMEM),
										.inALUout(),
										.innegative(), .inzero(), .inoverflow(), .incarry_out(), .incbzFlag(),
										
										.outUncondBr(), .outBrSel(), //control signals to PCincrementor
										.outPC(),
										.outReg2Loc(), .outRegWrite(RegWriteWB), .outMemWrite(), .outwrByte(), .outMemToReg(), .outimmSel(), .outALUsrc(), .outKZsel(), .outMOVsel(MOVselWB), .outsetFlag(), .outload(),//control signals to datapath
										.outRn(RnWB), .outRm(RmWB), .outRd(RdWB), //register
										.outALUop(),
										.outimm12(),
										.outimm16(),
										.outDAddr9(),
										.outCondAddr19(),
										.outBrAddr26(),
										.outLDURBsel(),
										.outSHAMT(),
										.outDw(), 		
										.outDa(), .outALUin(), .outDb(),
										.outMOVout(MOVoutWB), .outwrBout(wrBoutWB),
										.outALUout(),
										.outnegative(), .outzero(), .outoverflow(), .outcarry_out(), .outcbzFlag());
	
	//WB- Writeback value to register file
	WB_stage wbStage (.MOVsel(MOVselWB), .MOVout(MOVoutWB), .wrBout(wrBoutWB), .Dw(DwWB));


endmodule
module CameronCPU_testbench();

	logic clk, reset;
	
	CameronCPU dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; repeat (40) @(posedge clk);
		$stop;
	end
endmodule 
