`timescale 1ns/10ps
module BillyCPU (input logic clk, reset);
	
	logic UncondBr, BrTaken;
	logic [18:0] CondAddr19;
	logic [25:0] BrAddr26;
	logic [31:0] Instruction;
	logic zeroFlag, negativeFlag;
	logic Reg2Loc, RegWrite, 
			MemWrite, wrByte, MemToReg, 
			immSel, shiftSel, ALUsrc, KZsel, MOVsel,
			setFlag;
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
									.zeroFlag, .negativeFlag,
									.UncondBr, .BrTaken, //control signals to PCIncrementor
									.Reg2Loc, .RegWrite, .MemWrite, .wrByte, .MemToReg, .immSel, .shiftSel, .ALUsrc, .KZsel, .MOVsel, .setFlag,//control signals to datapath
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
						.Reg2Loc, .RegWrite, .MemWrite, .MemToReg, .immSel, .clk, .ALUsrc, .wrByte, .shiftSel, .KZsel, .MOVsel, .setFlag,
						.ALUop,
						.zero(zeroFlag), .negative(negativeFlag), .overflow(), .carry_out(),
						.DAddr9,
						.Imm12(imm12), //for ADDI
						.Imm16(imm16), //for MOVZ, MOVK
						.SHAMT, //shift amount for MOVZ, MOVK
						.LDURBsel //xfer-size for Data mem. (=1 when LDURB =8 when LDUR)
						);
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
		reset <= 0; repeat (18) @(posedge clk);
		$stop;
	end
endmodule