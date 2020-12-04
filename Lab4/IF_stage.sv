`timescale 1ns/10ps
module IF_stage  (input logic clk, reset,
						input logic negativeFlag, cbzFlag, //maybe we need an overflow flag for BLT: overflow^negative?
						input logic UncondBrRF, 
						input logic [1:0] BrSelRF,
						input logic [63:0]	PCRF,
						input logic [18:0]	CondAddr19RF,
						input logic [25:0]	BrAddr26RF,
						output logic UncondBr,
						output logic [1:0] BrSel, //control signals to PCIncrementor
						output logic Reg2Loc, RegWrite, MemWrite, wrByte, MemToReg, immSel, ALUsrc, KZsel, MOVsel, setFlag, load,//control signals to datapath
						output logic [4:0] 	Rn, Rm, Rd, //register
						output logic [2:0] 	ALUop,
						output logic [11:0] 	imm12,
						output logic [15:0] 	imm16,
						output logic [8:0]	DAddr9,
						output logic [18:0] 	CondAddr19,
						output logic [25:0] 	BrAddr26,
						output logic [3:0]	LDURBsel,
						output logic [1:0] 	SHAMT,
						output logic [63:0]	PCout);
						
	logic BrTaken;					
	//CBZ, BLT, B, normal
	mux4x1 BrTakenSel (.selector(BrSelRF), .in({cbzFlag, negativeFlag, 1'b1, 1'b0}), .out(BrTaken));
						
	logic [31:0] Instruction;
	PCIncrementor pc (.UncondBrRF, .BrTakenRF(BrTaken), .clk, .reset,
							.CondAddr19RF,
							.BrAddr26RF,
							.PCRF,
							.Instruction,
							.PCout);
	
	instrDecoder instrDec (.Instruction,
						.negativeFlag, .cbzFlag,
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
						.SHAMT);
endmodule
