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
	logic zeroFlag, negativeFlag, cbzFlag;
	
	PCIncrementor pc (.UncondBr, .BrTaken, .clk, .reset,
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
						.wrEn(1'b1), .clk, .reset, //**not sure about wrEn but we could look at it later
						//INPUT control signals to PCIncrementor
						.inUncondBr(UncondBr), .inBrTaken(BrTaken), 
						//INPUT control signals to datapath
						.inReg2Loc(Reg2Loc), .inRegWrite(RegWrite), .inMemWrite(MemWrite), .inwrByte(wrByte), 
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
	//TODO: 	1. Accelerate branch
	//			2. Delay Slot
	//			3. Forwarding

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
	
	alu ALU(.A(Da), .B(ALUin), .cntrl(ALUop), .result(ALUout), .negative(flags[0]), .zero(flags[1]), .overflow(flags[2]), .carry_out(flags[3]));
		
	//MEM- Data Memory
	datamem memory(.address(ALUout), .write_enable(MemWrite), 
		.read_enable(load), .write_data(Db), .clk, .xfer_size(LDURBsel), .read_data(Memout));
	
	//WB- Writeback value to register file
	/*datapath dataP (						
						.Rd, .Rn, .Rm,
						.Reg2Loc, .RegWrite, .MemWrite, .MemToReg, .immSel, .clk, .ALUsrc, .wrByte, .MOVsel, .setFlag, .load, .KZsel,
						.ALUop,
						.zero(zeroFlag), .negative(negativeFlag), .overflow(), .carry_out(), .cbzFlag,
						.DAddr9,
						.Imm12(imm12), //for ADDI
						.Imm16(imm16), //for MOVZ, MOVK
						.SHAMT, //shift amount for MOVZ, MOVK
						.LDURBsel);*/
endmodule

module BillyCPU_testbench();

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