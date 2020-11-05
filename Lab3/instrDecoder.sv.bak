module instrDecoder (
						input logic [31:0] Instruction,
						output logic UncondBr, BrTaken, //flags to PCIncrementor
						output logic Reg2Loc, RegWrite, MemWrite, MemToReg, immSel, ALUsrc, //flags to datapath
						output logic ALUop;)