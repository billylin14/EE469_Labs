module datapath (clk, Rd, Rn, Rm, Reg2Loc, RegWrite, 
						MemWrite, MemToReg, DAddr9, Imm12, ALUsrc, ALUop, zero);
	input logic [4:0] Rd, Rn, Rm;
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, ALUsrc, ALUop, clk;
	output logic zero;
	input logic [8:0] DAddr9;
	input logic [11:0] Imm12;
	
	logic [4:0] Aw, Ab, Aa;
	logic [63:0] Dw, Da, Db;
	
	genvar i;
	generate
	for (i=0; i<5; i++) begin buildReg2LocMux
		mux2x1 reg2location (Reg2Loc, {Rm[i], Rd[i]}, Ab[i]);
	endgenerate
	
	assign Aa = Rn;
	assign Aw = Rd;
	
	regfile registers (.clk, .ReadRegister1(Aa), .ReadRegister2(Ab), 
		.WriteRegister(Aw), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
	