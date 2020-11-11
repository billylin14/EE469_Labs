`timescale 1ns/10ps
module BillyCPU (input logic clk, reset);
	
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
	
	datapath dataP (						
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