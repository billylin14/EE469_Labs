// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 instrDecocer.sv

// Input with a 32-bit instruction and flags,
// Decodes the instruction bits and outputs corresponding registers, 
// immediate addresses, and control logics to datapath and PCIncrementor.

`timescale 1ns/10ps
module instrDecoder (
						input logic [31:0] Instruction,
						input logic zeroFlag, negativeFlag, cbzFlag,
						output logic UncondBr, BrTaken, //control signals to PCIncrementor
						output logic Reg2Loc, RegWrite, MemWrite, wrByte, MemToReg, immSel, ALUsrc, KZsel, MOVsel, setFlag, load,//control signals to datapath
						output logic [4:0] 	Rn, Rm, Rd, //register
						output logic [2:0] 	ALUop,
						output logic [11:0] 	imm12,
						output logic [15:0] 	imm16,
						output logic [8:0]	DAddr9,
						output logic [18:0] 	CondAddr19,
						output logic [25:0] 	BrAddr26,
						output logic [3:0]	LDURBsel,
						output logic [1:0] 	SHAMT);
						
	localparam ADDI  = 11'b1001000100x,
				  ADDS  = 11'b10101011000,
				  SUBS  = 11'b11101011000,
				  B	  = 11'b000101xxxxx,
				  BLT  = 11'b01010100xxx,
				  CBZ	  = 11'b10110100xxx,
				  LDUR  = 11'b11111000010,
				  LDURB = 11'b00111000010,
				  STUR  = 11'b11111000000,
				  STURB = 11'b00111000000,
				  MOVK  = 11'b111100101xx,
				  MOVZ  = 11'b110100101xx;
				  
//	//for CBZ
//	logic [63:0] norIn;
//	logic norOut;
//	assign norIn = {59'b0, Instruction[4:0]};
//	norGate64x1 zeroFlag_B (.in(norIn), .out(norOut));

	always_comb begin
		casex (Instruction[31:21])
			//ADDI: I-type, Reg[Rd] = Reg[Rn] + {'0, Imm12}
			//OP         Imm12        Rn    Rd
			//3322222222 221111111111 00000 00000
			//1098765432 109876543210 98765 43210
			//1001000100 Unsigned     0..31 0..31
			ADDI: begin //working
				Rn=Instruction[9:5]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'b0; BrTaken=1'b0;  					//Branching
				RegWrite=1'b1; Reg2Loc=1'bx;						//RegFile
				MemWrite=1'b0; MemToReg=1'b0; 					//Memory
				wrByte=1'b0;											//LDURB
				immSel=1'b1; ALUsrc=1'b1; ALUop=3'b010;
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = Instruction[21:10];
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//ADDS: R-type, Reg[Rd] = Reg[Rn] + Reg[Rm]
			//OP          Rm    Shamt  Rn    Rd
			//33222222222 21111 111111 00000 00000
			//10987654321 09876 543210 98765 43210
			//10101011000 0..31 000000 0..31 0..31
			ADDS: begin
				Rn=Instruction[9:5]; Rm=Instruction[20:16]; Rd=Instruction[4:0];
				
				UncondBr=1'b0; BrTaken=1'b0;  					//Branching
				RegWrite=1'b1; Reg2Loc=1'b1;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'b0; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'b0; ALUop=3'b010;		//ALUSrc
				wrByte=1'b0;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b1; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//SUBS: R-type, Reg[Rd] = Reg[Rn] - Reg[Rm]
			//OP          Rm    Shamt  Rn    Rd
			//33222222222 21111 111111 00000 00000
			//10987654321 09876 543210 98765 43210
			//11101011000 0..31 000000 0..31 0..31
			SUBS: begin
				Rn=Instruction[9:5]; Rm=Instruction[20:16]; Rd=Instruction[4:0];
				
				UncondBr=1'b0; BrTaken=1'b0;  					//Branching
				RegWrite=1'b1; Reg2Loc=1'b1;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'b0; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'b0; ALUop=3'b011;		//ALUSrc
				wrByte=1'b0;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b1; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//B: B-type, PC = PC + SignExtend({Imm26, 2'b00})
			//OP     Imm26
			//332222 22222211111111110000000000
			//109876 54321098765432109876543210
			//000101 2's Comp Imm26
			B: begin //working
				Rn=5'bx; Rm=5'bx; Rd=5'bx;
				
				UncondBr=1'b1; BrTaken=1'b1;  					//Branching
				RegWrite=1'b0; Reg2Loc=1'bx;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'bx; ALUop=3'bx;		//ALUSrc
				wrByte=1'b0;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = Instruction[25:0];
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//B.cond: CB-type, if (flags meet condition) PC = PC + SignExtend({Imm19, 2'b00})
			//OP       Imm19               Cond
			//33222222 2222111111111100000 01011
			//10987654 3210987654321098765 43210
			//01010100 2's Comp Imm19      0..15
			
			//cond doesn't matter since we only have B.LT this option
			BLT: begin
				Rn=5'bx; Rm=5'bx; Rd=5'bx;
				
				UncondBr=1'b0; BrTaken=negativeFlag;  			//Branching
				RegWrite=1'b0; Reg2Loc=1'bx;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'bx; ALUop=3'bx;		//ALUSrc
				wrByte=1'b0;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = Instruction[23:5];
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//CBZ: CB-type, if (R[Rt] == 0) PC = PC + SignExtend({Imm19, 2'b00})
			//OP       Imm19               Rt
			//33222222 2222111111111100000 00000
			//10987654 3210987654321098765 43210
			//10110100 2's Comp Imm19      0..31
			CBZ: begin //ask TA about B.LT (if B.LT immediately follows a CBZ)
				Rn=Instruction[4:0]; Rm=5'b11111; Rd=5'bx;
				
				UncondBr=1'b0; 
				BrTaken=cbzFlag;										//Branching
				RegWrite=1'b0; Reg2Loc=1'b1;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'b0; ALUop=3'b010;		//ALUSrc
				wrByte=1'b0;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b1; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = 9'bx;
				CondAddr19 = Instruction[23:5];
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			//LDUR: D-type, Reg[Rt] = Mem[Reg[Rn] + SignExtend(Imm9)]
			//OP          Imm9      00 Rn    Rt
			//33222222222 211111111 11 00000 00000
			//10987654321 098765432 10 98765 43210
			//11111000010 2's Comp  00 0..31 0..31
			LDUR: begin 
				Rn=Instruction[9:5]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 															//Branching
				RegWrite=1'b1; Reg2Loc=1'bx;															//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'b1; 														//Memory (STUR, LDUR)
				immSel=1'b0; ALUsrc=1'b1; ALUop=3'b010;				
				wrByte=1'b0;											//LDURB			//ALUSrc
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b1;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = Instruction[20:12];
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
			end
			
			//LDURB: D-type, Reg[Rt] = {52'b0, Mem[Reg[Rn] + SignExtend(Imm9)][7:0]}
			//OP          Imm9      00 Rn    Rt
			//33222222222 211111111 11 00000 00000
			//10987654321 098765432 10 98765 43210
			//00111000010 2's Comp  00 0..31 0..31
			LDURB: begin 
				Rn=Instruction[9:5]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 						//Branching
				RegWrite=1'b1; Reg2Loc=1'bx;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'b1; 					//Memory (STUR, LDUR)
				immSel=1'b0; ALUsrc=1'b1; ALUop=3'b010;		//ALUSrc
				wrByte=1'b1;											//LDURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b1;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = Instruction[20:12];
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b0001;
			end
			
			//STUR: D-type, Mem[Reg[Rn] + SignExtend(Imm9)] = Reg[Rt]
			//OP          Imm9      00 Rn    Rt
			//33222222222 211111111 11 00000 00000
			//10987654321 098765432 10 98765 43210
			//11111000000 2's Comp  00 0..31 0..31
			STUR: begin 
				Rn=Instruction[9:5]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 						//Branching
				RegWrite=1'b0; Reg2Loc=1'b0;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b1; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'b0; ALUsrc=1'b1; ALUop=3'b010;		//ALUSrc
				wrByte=1'b0;											//LDURB			
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = Instruction[20:12];
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b1000;
				
			end
			//STURB: D-type, Mem[Reg[Rn] + SignExtend(Imm9)][7:0] = Reg[Rt][7:0]
			//OP          Imm9      00 Rn    Rt
			//33222222222 211111111 11 00000 00000
			//10987654321 098765432 10 98765 43210
			//00111000000 2's Comp  00 0..31 0..31
			STURB: begin 
				Rn=Instruction[9:5]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 						//Branching
				RegWrite=1'b0; Reg2Loc=1'b0;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b1; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'b0; ALUsrc=1'b1; ALUop=3'b010;		//ALUSrc
				wrByte=1'b1;											//STURB
				KZsel=1'b0; MOVsel=1'b0;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = 16'bx;
				DAddr9 = Instruction[20:12];
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = 2'bx;
				LDURBsel = 4'b0001;
			end
			//MOVK: IM-type, Reg[Rd][16*shamt+15:16*shamt] = Imm16
			//OP        Shamt  Imm16            Rd
			//332222222 22     2111111111100000 00000
			//109876543 21     0987654321098765 43210
			//111100101 0..3   Unsigned         0..31
			MOVK: begin 
				
				Rn=Instruction[4:0]; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 						//Branching
				RegWrite=1'b1; Reg2Loc=1'bx;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'b0; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'b1; ALUop=3'b100;		//ALUSrc
				wrByte=1'b0;											//STURB
				KZsel=1'b1; MOVsel=1'b1;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = Instruction[20:5];
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = Instruction[22:21];
				LDURBsel = 4'b1000;
			end
			//MOVZ: IM-type, Reg[Rd] = {{'0, Imm16} << (Shamt * 16)}
			//OP        Shamt  Imm16            Rd
			//332222222 22     2111111111100000 00000
			//109876543 21     0987654321098765 43210
			//110100101 0..3   Unsigned         0..31
			MOVZ: begin 
				
				Rn=5'bx; Rm=5'bx; Rd=Instruction[4:0];
				
				UncondBr=1'bx; BrTaken=1'b0; 						//Branching
				RegWrite=1'b1; Reg2Loc=1'bx;						//RegFile (ADD, SUB, LDUR)
				MemWrite=1'b0; MemToReg=1'bx; 					//Memory (STUR, LDUR)
				immSel=1'bx; ALUsrc=1'bx; ALUop=3'bx;			//ALUSrc
				wrByte=1'bx;											//STURB
				KZsel=1'b0; MOVsel=1'b1;
				setFlag=1'b0; load = 1'b0;
				
				imm12 = 12'bx;
				imm16 = Instruction[20:5];
				DAddr9 = 9'bx;
				CondAddr19 = 19'bx;
				BrAddr26 = 26'bx;
				SHAMT = Instruction[22:21];
				LDURBsel = 4'b1000;
			end
		endcase
	end
endmodule