
`timescale 1ns/10ps
module datapath (clk, Rd, Rn, Rm, Reg2Loc, RegWrite, immSel, LDURBsel,
						MemWrite, MemToReg, DAddr9, Imm12, Imm16, ALUsrc, ALUop, 
						overflow, carry_out, zero, negative);
						
	input logic [4:0] Rd, Rn, Rm;
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, immSel, clk, ALUsrc; 
	input logic [2:0]ALUop;
	output logic zero, negative, overflow, carry_out;
	input logic [8:0] DAddr9;
	input logic [11:0] Imm12; //for ADDI
	input logic [15:0] Imm16; //for MOVZ, MOVK
	input logic [1:0] SHAMT; //shift amount for MOVZ, MOVK
	input logic [3:0] LDURBsel; //xfer-size for Data mem. (=1 when LDURB =8 when LDUR)
	
	logic [4:0] Aw, Ab, Aa;
	logic [63:0] Dw, Da, Db, ALUin,
					 Memout, ALUout, 
	             imm12_pad, //ADDI path
	             DAddr9_SE, //LDUR(B), STUR(B) path
					 imm,			//output from immSelector into ALUSrCSel
	             imm16_pad, imm16_shifted, //MOVZ, MOVK path
					 shift;		//output from ALUSrcSel into ALU
	
	genvar i;
	generate
	for (i=0; i<5; i++)begin: build5bitMux
		mux2x1 reg2location (.selector(Reg2Loc), .in({Rm[i], Rd[i]}), .out(Ab[i]));
	end
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 immSelector (.selector(immSel), .in({imm12_pad[i], DAddr9_SE[i]}), .out(imm[i]));
		mux2x1 ALUSrcSel 	(.selector(ALUSrc), .in({shift[i], Db[i]}), .out(ALUin));
		mux2x1 MemOutSel (.selector(MemToReg), .in({Memout[i], ALUout[i]}), .out(Dw[i]));
		mux2x1 ShiftSelector (.selector(shiftSel), .in({imm16_shift[i], imm[i]}), .out(shift[i]));
	end
	endgenerate
	
	
	assign Aa = Rn;
	assign Aw = Rd;
	
	regfile registers (.clk, .ReadRegister1(Aa), .ReadRegister2(Ab), 
		.WriteRegister(Aw), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
	
	se #(9) SE1(.in(DAddr9), .out(DAddr9_SE));
	assign imm12_pad = {52'b0, Imm12};
	assign imm16_pad = {48'b0, Imm16};
	
	leftShift #(SHAMT) (.in(imm16_pad), .out(imm16_shifted));
	
	
	alu ALU(.A(Da), .B(ALUin), .cntrl(ALUOp), .result(ALUout), .negative, .zero, .overflow, .carry_out);
	
	datamem memory(.address(ALUout), .write_enable(MemWrite), .read_enable(1), .write_data(Db), .clk,
						.xfer_size(LDURBsel), .read_data(Memout));
						
endmodule


//No simple way to testbench without entire CPU