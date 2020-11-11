
`timescale 1ns/10ps
module datapath (						
	input logic [4:0] Rd, Rn, Rm,
	input logic Reg2Loc, RegWrite, MemWrite, MemToReg, immSel, clk, ALUsrc, wrByte, MOVsel, setFlag, load, KZsel,
	input logic [2:0]ALUop,
	output logic zero, negative, overflow, carry_out, cbzFlag,
	input logic [8:0] DAddr9,
	input logic [11:0] Imm12, //for ADDI
	input logic [15:0] Imm16, //for MOVZ, MOVK
	input logic [1:0] SHAMT, //shift amount for MOVZ, MOVK
	input logic [3:0] LDURBsel, shiftSHAMT //xfer-size for Data mem. (=0 when LDURB =7 when LDUR)
	);
	
	logic [4:0] Aw, Ab, Aa;
	logic [63:0] Dw, Da, Db, ALUin,
					 Memout, Memout2, ALUout, wrBout, MOVout,
					 byteResult,
	             imm12_pad, //ADDI path
	             DAddr9_SE, //LDUR(B), STUR(B) path
					 imm,			//output from immSelector into ALUSrCSel
					 imm16_extended, KZin;
					 
	assign byteResult = {56'b0, Memout2[7:0]};
	
	genvar i;
	genvar j;
	generate
	for (i=0; i<5; i++)begin: build5bitMux
		mux2x1 reg2location (.selector(Reg2Loc), .in({Rm[i], Rd[i]}), .out(Ab[i]));
	end
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 immSelector (.selector(immSel), .in({imm12_pad[i], DAddr9_SE[i]}), .out(imm[i]));
		mux2x1 ALUSrcSel 	(.selector(ALUsrc), .in({imm[i], Db[i]}), .out(ALUin[i]));
		mux2x1 MemOutSel (.selector(MemToReg), .in({Memout[i], ALUout[i]}), .out(Memout2[i]));
		mux2x1 WrByteMUX (.selector(wrByte), .in({byteResult[i], Memout2[i]}), .out(wrBout[i]));
		mux2x1 MOVselector (.selector(MOVsel), .in({MOVout[i], wrBout[i]}), .out(Dw[i]));
		mux2x1 KZselector (.selector(KZsel), .in({Da[i], 1'b0}), .out(KZin));
	end
	for (i=0; i<4; i++)begin: movBitSel
		for (j=0; j<16; j++)begin: padMuxes
			mux2x1 movBit (.selector(shiftSHAMT[i]), .in({imm16[j], KZin[16*i+j]}), .out(KZresult[16*i+j]));
	endgenerate
	
	decoder2x4 cntrlSHAMT (.enable(MOVsel), .in(SHAMT), .out(shiftSHAMT));
	
	assign Aa = Rn;
	assign Aw = Rd;
	
	logic [3:0] flags;
	
	regfile registers (.clk, .ReadRegister1(Aa), .ReadRegister2(Ab), 
		.WriteRegister(Aw), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
	
	se #(9) SE1(.in(DAddr9), .out(DAddr9_SE));
	assign imm12_pad = {52'b0, Imm12};
	assign imm16_pad = {48'b0, Imm16};
	assign imm16_extended = 
	
	leftShift shiftSHAMT (.SHAMT(SHAMT), .in(imm16_pad), .out(imm16_shift));
	
	alu ALU(.A(Da), .B(ALUin), .cntrl(ALUop), .result(ALUout), .negative(flags[0]), .zero(flags[1]), .overflow(flags[2]), .carry_out(flags[3]));
	
	datamem memory(.address(ALUout), .write_enable(MemWrite), .read_enable(load), .write_data(Db), .clk,
						.xfer_size(LDURBsel), .read_data(Memout));
	
	dff_real negDff (.in(flags[0]), .en(setFlag), .out(negative), .clk);
	dff_real zeroDff (.in(flags[1]), .en(setFlag), .out(zero), .clk);
	dff_real ofDff (.in(flags[2]), .en(setFlag), .out(overflow), .clk);
	dff_real coutDff (.in(flags[3]), .en(setFlag), .out(carry_out), .clk);	
	
	and #0.05 andZero (cbzFlag, flags[1], setFlag); 
						
endmodule


//No simple way to testbench without entire CPU