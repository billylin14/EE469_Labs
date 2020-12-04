// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 RF_Stage.sv

// Input with a clock, control signals, and data from IF stage,
// Outputs the newest data from the register file and from the forwarding unit.

`timescale 1ns/10ps
module RF_stage  (input logic clk, //invert this later
						input logic Reg2Loc, immSel, ALUsrc, setFlag, MOVsel, load, memWrite,//control signals to datapath
						input logic [4:0] 	Rn, Rm, Rd, //register
						input logic [11:0] 	imm12,
						input logic [8:0]		DAddr9,
						input logic [4:0]		AwWB,				//from WB stage to write
						input logic [63:0]	Dw, 		 		//from WB stage mux to write
						input logic 			RegWrite, 		//from WB to write
						input logic [63:0]	DwMEM, ALUoutEX,	//for forwarding, from EX and MEM
						input logic [4:0]		AwEX, AwMEM, 		//for forwarding
						input logic [63:0]	MOVoutEX,			//for forwarding (MOVZ, MOVK)
						input logic memWriteEX,
						input logic [63:0] DbEX,
						output logic [63:0] 	Da, ALUin, Db);
	logic notClk;
	not #0.05 (notClk, clk);	
	logic [4:0] Ab;
	logic [63:0] DAddr9_SE, imm12_pad, imm, DaRF, ALUinRF, DbReg, outEX;
	
	//Forwarding unit
	logic [1:0] DaSEL, DbSEL, ALUSEL;
	
	se #(9) SE1(.in(DAddr9), .out(DAddr9_SE));
	assign imm12_pad = {52'b0, imm12};
	
	genvar i;
	generate
	for (i=0; i<5; i++)begin: build5bitMux
		mux2x1 reg2location (.selector(Reg2Loc), .in({Rm[i], Rd[i]}), .out(Ab[i]));
	end
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 immSelector (.selector(immSel), .in({imm12_pad[i], DAddr9_SE[i]}), .out(imm[i]));
		mux2x1 ALUSrcSel 	(.selector(ALUsrc), .in({imm[i], Db[i]}), .out(ALUinRF[i]));
		//Forwarding MUX
		mux4x1 DaRF_MUX (.selector(DaSEL), .in({MOVoutEX[i], 	DaRF[i], 		DwMEM[i], 	ALUoutEX[i]}), .out(Da[i]));
		mux4x1 ALU_MUX (.selector(ALUSEL), .in({MOVoutEX[i], 	ALUinRF[i], 	DwMEM[i], 	ALUoutEX[i]}), .out(ALUin[i]));
		mux2x1 selOut_MUX (.selector(MOVsel), .in({MOVoutEX[i], ALUoutEX[i]}), .out(outEX[i]));
		mux4x1 DbRF_MUX (.selector(DbSEL), .in({DbEX[i], 		DbReg[i], 		DwMEM[i], 	outEX[i]}), .out(Db[i]));

		end
	endgenerate
	
	forwardingUnit forward (.MOVsel, .load, .memWrite, .memWriteEX,
									.AaRF(Rn), .AbRF(Ab), .AwEX(AwEX), .AwMEM(AwMEM),
									.DaSEL, .DbSEL, .ALUSEL);
	regfile registers (.clk(notClk), .ReadRegister1(Rn), .ReadRegister2(Ab), 
		.WriteRegister(AwWB), .WriteData(Dw), .ReadData1(DaRF), .ReadData2(DbReg), .RegWrite);
endmodule
