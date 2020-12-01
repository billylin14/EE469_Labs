// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 CameronCPU.sv

// Input with a clock and a reset signal,
// Performs the specified instruction set from the instruction memory (instrmem) and
// Acts as a single cycle CPU that performs one instruction in a cycle
<<<<<<< HEAD

//PLAN:
//1. make pipeline working without adding any extra hardware
// **check if structural hazard (padding stages) exists in our implementation**
//2. invert the clock signal for regfile
//3. add accelerate branches
//4. add forwarding unit
//5. **not sure about the delay slots (do NOOP? switch order of instruction??)
//**in the pipeline_registers, we might not need to store every logic

=======
/*
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309

`timescale 1ns/10ps
module CameronCPU (input logic clk, reset);
	
	//IF- Instruction Fetch
	logic [31:0] Instruction;
	logic UncondBr, BrTaken; //control signals to PCIncrementor
	logic Reg2Loc, RegWrite, MemWrite, wrByte, MemToReg, immSel,
			ALUsrc, KZsel, MOVsel, setFlag, load;//control signals to datapath
	logic [4:0] 	Rn, Rm, Rd; //register
	logic [2:0] 	ALUop;
	logic [11:0] 	imm12;
	logic [15:0] 	imm16;
	logic [8:0]		DAddr9;
	logic [18:0] 	CondAddr19;
	logic [25:0] 	BrAddr26;
	logic [3:0]		LDURBsel;
	logic [1:0] 	SHAMT;
<<<<<<< HEAD
	logic zeroFlag, negativeFlag, cbzFlag;
	
	PCIncrementor pc (.UncondBr, .BrTaken, .clk, .reset,
=======
	
	/*PCIncrementor pc (.UncondBr, .BrTaken, .clk, .reset,
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309
							.CondAddr19,
							.BrAddr26,
							.Instruction);
				
	instrDecoder instrDec (.Instruction,
						.zeroFlag, .negativeFlag, .cbzFlag,
						.UncondBr, .BrTaken, //control signals to PCIncrementor
						.Reg2Loc, .RegWrite, .MemWrite, .wrByte, .MemToReg, .immSel, .ALUsrc, .KZsel, .MOVsel, .setFlag, .load,//control signals to datapath
						.Rn, .Rm, .Rd, //register
						.ALUop,
						.imm12,
						.imm16,
						.DAddr9,
						.CondAddr19,
						.BrAddr26,
						.LDURBsel,
						.SHAMT);
	
	pipeline_registers IF2RF(
<<<<<<< HEAD
						.wrEn(1'b1), .clk, .reset, //**not sure about wrEn but we could look at it later
						//INPUT control signals to PCIncrementor
						.inUncondBr(UncondBr), .inBrTaken(BrTaken), 
						//INPUT control signals to datapath
						.inReg2Loc(Reg2Loc), .inRegWrite(RegWrite), .inMemWrite(MemWrite), .inwrByte(wrByte), 
=======
						.wrEn, .clk, .reset,
						.inUncondBr(UncondBr), .inBrTaken(BrTaken), //control signals to PCIncrementor
						.inReg2Loc(Reg2Loc), .inRegWrite(RegWrite), .inMemWrite(MemWrite), .inwrByte(wrByte), //control signals to datapath
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309
						.inMemToReg(MemToReg), .inimmSel(immSel), .inALUsrc(ALUsrc), .inKZsel(KZsel), 
						.inMOVsel(MOVsel), .insetFlag(setFlag), .inload(load),
						//INPUT registers
						.inRn(Rn), .inRm(Rm), .inRd(Rd), 
						.inALUop(ALUop),
						//INPUT immediates
						.inimm12(imm12),
						.inimm16(imm16),
						.inDAddr9(DAddr9),
						.inCondAddr19(CondAddr19),
						.inBrAddr26(BrAddr26),
						.inLDURBsel(LDURBsel),
						.inSHAMT(SHAMT),
						
						//OUTPUT control signals to PCIncrementor
						.outUncondBr(UncondBrRF), .outBrTaken(BrTakenRF), 
						//OUTPUT control signals to datapath
						.outReg2Loc(Reg2LocRF), .outRegWrite(RegWriteRF), .outMemWrite(MemWriteRF), .outwrByte(wrByteRF), 
						.outMemToReg(MemToRegRF), .outimmSel(immSelRF), .outALUsrc(ALUsrcRF), .outKZsel(KZselRF), .outMOVsel(MOVselRF),
						.outsetFlag(setFlagRF), .outload(loadRF),
						//OUTPUT registers
						.outRn(RnRF), .outRm(RmRF), .outRd(RdRF), 
						.outALUop(ALUopRF),
						//OUTPUT immediates
						.outimm12(imm12RF),
						.outimm16(imm16RF),
						.outDAddr9(DAddr9RF),
						.outCondAddr19(CondAddr19RF),
						.outBrAddr26(BrAddr26RF),
						.outLDURBsel(LDURBselRF),
						.outSHAMT(SHAMTRF));

	
	//RF- Register Fetch
<<<<<<< HEAD
	//TODO: 	1. Accelerate branch
	//			2. Delay Slot
	//			3. Forwarding

	logic UncondBrRF, BrTakenRF; //control signals to PCIncrementor
=======
	//TODO: 	
	//			1. Delay Slot
	//			2. Forwarding ()
	//					-wire .WriteData
	//					-add logic for DwMEM and DwEX


	
	logic UncondBrRF, BrTakenRF, negclk; //control signals to PCIncrementor
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309
	logic Reg2LocRF, RegWriteRF, MemWriteRF, wrByteRF, MemToRegRF, immSelRF,
			ALUsrcRF, KZselRF, MOVselRF, setFlagRF, loadRF;//control signals to datapath
	logic [4:0] 	RnRF, RmRF, RdRF; //register
	logic [2:0] 	ALUopRF;
	logic [11:0] 	imm12RF;
	logic [15:0] 	imm16RF;
	logic [8:0]		DAddr9RF;
	logic [18:0] 	CondAddr19RF;
	logic [25:0] 	BrAddr26RF;
	logic [3:0]		LDURBselRF;
	logic [1:0] 	SHAMTRF;
	logic [4:0] 	AbRF;
	
	genvar i;
	generate
		for (i=0; i<5; i++)begin: build5bitMux
			mux2x1 reg2location (.selector(Reg2LocRF), .in({RmRF[i], RdRF[i]}), .out(AbRF[i]));
		end
		for (i=0; i<64; i++)begin: build64bitFwdMUX
			mux4x1 DaSelector (.selector(DaSEL), .in({1'b0, DaRF[i], DwMEM[i], DwEX[i]}), .out(DaFinal[i]));
			mux4x1 DbSelector (.selector(DbSEL), .in({1'b0, DbRF[i], DwMEM[i], DwEX[i]}), .out(DbFinal[i]));
		end
	endgenerate
	
	not #0.05 (negclk, clk);
	
	regfile registers (.clk(negclk), .ReadRegister1(RnRF), .ReadRegister2(AbRF), 
		.WriteRegister(RdRF), .WriteData(/*TODO), .ReadData1(Da), .ReadData2(Db), .RegWrite);
	logic [63:0] DaRF, DbRF, DaFinal, DbFinal;
	
<<<<<<< HEAD
	
	generate
		for (i=0; i<5; i++)begin: build5bitMux
			mux2x1 reg2location (.selector(Reg2Loc), .in({Rm[i], Rd[i]}), .out(Ab[i]));
		end
	endgenerate
	
	regfile registers (.clk, .ReadRegister1(RnRF), .ReadRegister2(Ab), 
		.WriteRegister(RdRF), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
		
	pipeline_registers RF2EX(
						.wrEn(1'b1), .clk, .reset, //**not sure about wrEn but we could look at it later
						//INPUT control signals to PCIncrementor
						.inUncondBr(UncondBrRF), .inBrTaken(BrTakenRF), 
						//INPUT control signals to datapath
						.inReg2Loc(Reg2LocRF), .inRegWrite(RegWriteRF), .inMemWrite(MemWriteRF), .inwrByte(wrByteRF), 
						.inMemToReg(MemToRegRF), .inimmSel(immSelRF), .inALUsrc(ALUsrcRF), .inKZsel(KZselRF), 
						.inMOVsel(MOVselRF), .insetFlag(setFlagRF), .inload(loadRF),
						//INPUT registers
						.inRn(RnRF), .inRm(RmRF), .inRd(RdRF), 
						.inALUop(ALUopRF),
						//INPUT immediates
						.inimm12(imm12RF),
						.inimm16(imm16RF),
						.inDAddr9(DAddr9RF),
						.inCondAddr19(CondAddr19RF),
						.inBrAddr26(BrAddr26RF),
						.inLDURBsel(LDURBselRF),
						.inSHAMT(SHAMTRF),
						
						//OUTPUT control signals to PCIncrementor
						.outUncondBr(UncondBrRF), .outBrTaken(BrTakenRF), 
						//OUTPUT control signals to datapath
						.outReg2Loc(Reg2LocRF), .outRegWrite(RegWriteRF), .outMemWrite(MemWriteRF), .outwrByte(wrByteRF), 
						.outMemToReg(MemToRegRF), .outimmSel(immSelRF), .outALUsrc(ALUsrcRF), .outKZsel(KZselRF), .outMOVsel(MOVselRF),
						.outsetFlag(setFlagRF), .outload(loadRF),
						//OUTPUT register
						.outRn(RnRF), .outRm(RmRF), .outRd(RdRF), 
						.outALUop(ALUopRF),
						//OUTPUT immediates
						.outimm12(imm12RF),
						.outimm16(imm16RF),
						.outDAddr9(DAddr9RF),
						.outCondAddr19(CondAddr19RF),
						.outBrAddr26(BrAddr26RF),
						.outLDURBsel(LDURBselRF),
						.outSHAMT(SHAMTRF));
	
	//EX- Execute
	logic UncondBrRF, BrTakenRF; //control signals to PCIncrementor
	logic Reg2LocRF, RegWriteRF, MemWriteRF, wrByteRF, MemToRegRF, immSelRF,
			ALUsrcRF, KZselRF, MOVselRF, setFlagRF, loadRF;//control signals to datapath
	logic [4:0] 	RnRF, RmRF, RdRF; //register
	logic [2:0] 	ALUopRF;
	logic [11:0] 	imm12RF;
	logic [15:0] 	imm16RF;
	logic [8:0]		DAddr9RF;
	logic [18:0] 	CondAddr19RF;
	logic [25:0] 	BrAddr26RF;
	logic [3:0]		LDURBselRF;
	logic [1:0] 	SHAMTRF;
	
	logic [4:0] 	Ab;
=======
	/*forwardingUnit fwd (.AaRF(RnRF), AbRF, AwEX, AwMEM,
								DaSEL, DbSEL);
								
	pipeline_registers RF2EX(
					.wrEn, .clk, .reset,
					.inUncondBr(UncondBrRF), .inBrTaken(BrTakenRF), //control signals to PCIncrementor
					.inReg2Loc(Reg2LocRF), .inRegWrite(RegWriteRF), .inMemWrite(MemWriteRF), .inwrByte(wrByteRF), //control signals to datapath
					.inMemToReg(MemToRegRF), .inimmSel(immSelRF), .inALUsrc(ALUsrcRF), .inKZsel(KZselRF), 
					.inMOVsel(MOVselRF), .insetFlag(setFlagRF), .inload(loadRF),
					.inRn(RnRF), .inRm(RmRF), .inRd(RdRF), //registers
					.inALUop(ALUopRF),
					.inimm12(imm12RF),
					.inimm16(imm16RF),
					.inDAddr9(DAddr9RF),
					.inCondAddr19(CondAddr19RF),
					.inBrAddr26(BrAddr26RF),
					.inLDURBsel(LDURBselRF),
					.inSHAMT(SHAMTRF),
					.outUncondBr(UncondBrEX), .outBrTaken(BrTakenEX), //control signals to PCIncrementor
					.outReg2Loc(Reg2LocEX), .outRegWrite(RegWriteEX), .outMemWrite(MemWriteEX), .outwrByte(wrByteEX), //control signals to datapath
					.outMemToReg(MemToRegEX), .outimmSel(immSelEX), .outALUsrc(ALUsrcEX), .outKZsel(KZselEX), .outMOVsel(MOVselEX),
					.outsetFlag(setFlagEX), .outload(loadEX),
					.outRn(RnEX), .outRm(RmEX), .outRd(RdEX), //register
					.outALUop(ALUopEX),
					.outimm12(imm12EX),
					.outimm16(imm16EX),
					.outDAddr9(DAddr9EX),
					.outCondAddr19(CondAddr19EX),
					.outBrAddr26(BrAddr26EX),
					.outLDURBsel(LDURBselEX),
					.outSHAMT(SHAMTEX));
	
	//EX- Execute
	//TODO:	1. include MOVZ/MOVK here
	
	logic UncondBrEX, BrTakenEX; //control signals to PCIncrementor
	logic Reg2LocEX, RegWriteEX, MemWriteEX, wrByteEX, MemToRegEX, immSelEX,
			ALUsrcEX, KZselEX, MOVselEX, setFlagEX, loadEX;//control signals to datapath
	logic [4:0] 	RnEX, RmEX, RdEX; //register
	logic [2:0] 	ALUopEX;
	logic [11:0] 	imm12EX;
	logic [15:0] 	imm16EX;
	logic [8:0]		DAddr9EX;
	logic [18:0] 	CondAddr19EX;
	logic [25:0] 	BrAddr26EX;
	logic [3:0]		LDURBselEX;
	logic [1:0] 	SHAMTEX;
>>>>>>> c271c725f188e3bafcb6a1ae88e45d6b3c56d309
	
	alu ALU(.A(Da), .B(ALUin), .cntrl(ALUop), .result(ALUout), .negative(flags[0]), .zero(flags[1]), .overflow(flags[2]), .carry_out(flags[3]));
	
	pipeline_registers EX2MEM(
					.wrEn, .clk, .reset,
					.inUncondBr(UncondBrEX), .inBrTaken(BrTakenEX), //control signals to PCIncrementor
					.inReg2Loc(Reg2LocEX), .inRegWrite(RegWriteEX), .inMemWrite(MemWriteEX), .inwrByte(wrByteEX), //control signals to datapath
					.inMemToReg(MemToRegEX), .inimmSel(immSelEX), .inALUsrc(ALUsrcEX), .inKZsel(KZselEX), 
					.inMOVsel(MOVselEX), .insetFlag(setFlagEX), .inload(loadEX),
					.inRn(RnEX), .inRm(RmEX), .inRd(RdEX), //registers
					.inALUop(ALUopEX),
					.inimm12(imm12EX),
					.inimm16(imm16EX),
					.inDAddr9(DAddr9EX),
					.inCondAddr19(CondAddr19EX),
					.inBrAddr26(BrAddr26EX),
					.inLDURBsel(LDURBselEX),
					.inSHAMT(SHAMTEX),
					.outUncondBr(UncondBrMEM), .outBrTaken(BrTakenMEM), //control signals to PCIncrementor
					.outReg2Loc(Reg2LocMEM), .outRegWrite(RegWriteMEM), .outMemWrite(MemWriteMEM), .outwrByte(wrByteMEM), //control signals to datapath
					.outMemToReg(MemToRegMEM), .outimmSel(immSelMEM), .outALUsrc(ALUsrcMEM), .outKZsel(KZselMEM), .outMOVsel(MOVselMEM),
					.outsetFlag(setFlagMEM), .outload(loadMEM),
					.outRn(RnMEM), .outRm(RmMEM), .outRd(RdMEM), //register
					.outALUop(ALUopMEM),
					.outimm12(imm12MEM),
					.outimm16(imm16MEM),
					.outDAddr9(DAddr9MEM),
					.outCondAddr19(CondAddr19MEM),
					.outBrAddr26(BrAddr26MEM),
					.outLDURBsel(LDURBselMEM),
					.outSHAMT(SHAMTMEM));
	
	//MEM- Data Memory
	logic UncondBrMEM, BrTakenMEM; //control signals to PCIncrementor
	logic Reg2LocMEM, RegWriteMEM, MemWriteMEM, wrByteMEM, MemToRegMEM, immSelMEM,
			ALUsrcMEM, KZselMEM, MOVselMEM, setFlagMEM, loadMEM;//control signals to datapath
	logic [4:0] 	RnMEM, RmMEM, RdMEM; //register
	logic [2:0] 	ALUopMEM;
	logic [11:0] 	imm12MEM;
	logic [15:0] 	imm16MEM;
	logic [8:0]		DAddr9MEM;
	logic [18:0] 	CondAddr19MEM;
	logic [25:0] 	BrAddr26MEM;
	logic [3:0]		LDURBselMEM;
	logic [1:0] 	SHAMTMEM;
	
	pipeline_registers MEM2WB(
					.wrEn, .clk, .reset,
					.inUncondBr(UncondBrMEM), .inBrTaken(BrTakenMEM), //control signals to PCIncrementor
					.inReg2Loc(Reg2LocMEM), .inRegWrite(RegWriteMEM), .inMemWrite(MemWriteMEM), .inwrByte(wrByteMEM), //control signals to datapath
					.inMemToReg(MemToRegMEM), .inimmSel(immSelMEM), .inALUsrc(ALUsrcMEM), .inKZsel(KZselMEM), 
					.inMOVsel(MOVselMEM), .insetFlag(setFlagMEM), .inload(loadMEM),
					.inRn(RnMEM), .inRm(RmMEM), .inRd(RdMEM), //registers
					.inALUop(ALUopMEM),
					.inimm12(imm12MEM),
					.inimm16(imm16MEM),
					.inDAddr9(DAddr9MEM),
					.inCondAddr19(CondAddr19MEM),
					.inBrAddr26(BrAddr26MEM),
					.inLDURBsel(LDURBselMEM),
					.inSHAMT(SHAMTMEM),
					.outUncondBr(UncondBrWB), .outBrTaken(BrTakenWB), //control signals to PCIncrementor
					.outReg2Loc(Reg2LocWB), .outRegWrite(RegWriteWB), .outWBWrite(WBWriteWB), .outwrByte(wrByteWB), //control signals to datapath
					.outMemToReg(MemToRegWB), .outimmSel(immSelWB), .outALUsrc(ALUsrcWB), .outKZsel(KZselWB), .outMOVsel(MOVselWB),
					.outsetFlag(setFlagWB), .outload(loadWB),
					.outRn(RnWB), .outRm(RmWB), .outRd(RdWB), //register
					.outALUop(ALUopWB),
					.outimm12(imm12WB),
					.outimm16(imm16WB),
					.outDAddr9(DAddr9WB),
					.outCondAddr19(CondAddr19WB),
					.outBrAddr26(BrAddr26WB),
					.outLDURBsel(LDURBselWB),
					.outSHAMT(SHAMTWB));
	
	datamem memory(.address(ALUout), .write_enable(MemWrite), 
		.read_enable(load), .write_data(Db), .clk, .xfer_size(LDURBsel), .read_data(Memout));
	
	
	//WB- Writeback value to register file
	logic UncondBrWB, BrTakenWB; //control signals to PCIncrementor
	logic Reg2LocWB, RegWriteWB, MemWriteWB, wrByteWB, MemToRegWB, immSelWB,
			ALUsrcWB, KZselWB, MOVselWB, setFlagWB, loadWB;//control signals to datapath
	logic [4:0] 	RnWB, RmWB, RdWB; //register
	logic [2:0] 	ALUopWB;
	logic [11:0] 	imm12WB;
	logic [15:0] 	imm16WB;
	logic [8:0]		DAddr9WB;
	logic [18:0] 	CondAddr19WB;
	logic [25:0] 	BrAddr26WB;
	logic [3:0]		LDURBselWB;
	logic [1:0] 	SHAMTWB;
					
	/*datapath dataP (						
						.Rd, .Rn, .Rm,
						.Reg2Loc, .RegWrite, .MemWrite, .MemToReg, .immSel, .clk, .ALUsrc, .wrByte, .MOVsel, .setFlag, .load, .KZsel,
						.ALUop,
						.zero(zeroFlag), .negative(negativeFlag), .overflow(), .carry_out(), .cbzFlag,
						.DAddr9,
						.Imm12(imm12), //for ADDI
						.Imm16(imm16), //for MOVZ, MOVK
						.SHAMT, //shift amount for MOVZ, MOVK
						.LDURBsel);
endmodule

module CameronCPU_testbench();

	logic clk, reset;
	
	BillyCPU dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; repeat (25) @(posedge clk);
		$stop;
	end
endmodule 
*/