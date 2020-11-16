// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 CameronCPU.sv

// Input with a clock and a reset signal,
// Performs the specified instruction set from the instruction memory (instrmem) and
// Acts as a single cycle CPU that performs one instruction in a cycle


`timescale 1ns/10ps
module CameronCPU (input logic clk, reset);
	
	logic UncondBr, BrTaken;
	logic [18:0] CondAddr19;
	logic [25:0] BrAddr26;
	logic [31:0] Instruction;
	logic zeroFlag, negativeFlag, cbzFlag;
	logic Reg2Loc, RegWrite, 
			MemWrite, wrByte, MemToReg, 
			immSel, ALUsrc, KZsel, MOVsel,
			setFlag, load;
	logic [4:0] Rn, Rm, Rd;
	logic [2:0] ALUop;
	logic [11:0] imm12;
	logic [15:0] imm16;
	logic [8:0] DAddr9;
	logic [3:0] LDURBsel;
	logic [1:0] SHAMT;
	
	//IF- Instruction Fetch
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
						.wrEn, .clk, .reset,
						.inUncondBr, .inBrTaken, //control signals to PCIncrementor
						.inReg2Loc(Reg2Loc), .inRegWrite(RegWrite), .inMemWrite(MemWrite), .inwrByte(wrByte), //control signals to datapath
						.inMemToReg(MemToReg), .inimmSel(immSel), .inALUsrc(ALUsrc), .inKZsel(KZsel), 
						.inMOVsel(MOVsel), .insetFlag(setFlag), .inload(load),
						.inRn(Rn), .inRm(Rm), .inRd(Rd), //registers
						.inALUop(ALUop),
						.inimm12(imm12),
						.inimm16(imm16),
						.inDAddr9(DAddr9),
						.inCondAddr19(CondAddr19),
						.inBrAddr26(BrAddr26),
						.inLDURBsel(LDURBsel),
						.inSHAMT(SHAMT),
						.outUncondBr(UncondBrRF), .outBrTaken(BrTakenRF), //control signals to PCIncrementor
						.outReg2Loc(Reg2LocRF), .outRegWrite(RegWriteRF), .outMemWrite(MemWriteRF), .outwrByte(wrByteRF), //control signals to datapath
						.outMemToReg(MemToRegRF), .outimmSel(immSelRF), .outALUsrc(ALUsrcRF), .outKZsel(KZselRF), .outMOVsel(MOVselRF),
						.outsetFlag(setFlagRF), .outload(loadRF),
						.outRn(RnRF), .outRm(RmRF), .outRd(RdRF), //register
						.outALUop(ALUopRF),
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
	
	regfile registers (.clk, .ReadRegister1(Aa), .ReadRegister2(Ab), 
		.WriteRegister(Aw), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
	
	//EX- Execute
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