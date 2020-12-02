`timescale 1ns/10ps
module RF_stage  (input logic clk, //invert this later
						input logic Reg2Loc, immSel, ALUsrc, setFlag,//control signals to datapath
						input logic [4:0] 	Rn, Rm, Rd, //register
						input logic [11:0] 	imm12,
						input logic [8:0]		DAddr9,
						input logic [63:0]	Dw, 		 		//from WB stage mux
						input logic 			RegWrite, 		//from WB
						input logic [63:0]	DwMEM, ALUoutEX,	//for forwarding, from EX and MEM
						input logic [4:0]		AwEX, AwMEM, 
						output logic [63:0] 	Da, ALUin, Db);
						
	logic [4:0] Ab;
	logic [63:0] DAddr9_SE, imm12_pad, imm, DaRF, ALUinRF;
	
	//Forwarding unit
	logic [1:0] DaSEL, DbSEL;
	
	se #(9) SE1(.in(DAddr9), .out(DAddr9_SE));
	assign imm12_pad = {52'b0, imm12};
	
	genvar i;
	generate
	for (i=0; i<5; i++)begin: build5bitMux
		mux2x1 reg2location (.selector(Reg2Loc), .in({Rm[i], Rd[i]}), .out(Ab[i]));
	end
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 immSelector (.selector(immSel), .in({imm12_pad[i], DAddr9_SE[i]}), .out(imm[i]));
		mux2x1 ALUSrcSel 	(.selector(ALUsrc), .in({imm[i], Db[i]}), .out(ALUin[i]));
		//Forwarding MUX
		mux4x1 DaRF_MUX (.selector(DaSEL), .in({1'b0, DaRF[i], DwMEM[i], ALUoutEX[i]}), .out(Da));
		mux4x1 DbRF_MUX (.selector(DbSEL), .in({1'b0, ALUinRF[i], DwMEM[i], ALUoutEX[i]}), .out(ALUin));
		end
	endgenerate
	
	forwardingUnit forward (.AaRF(Rn), .AbRF(Ab), .AwEX(AwEX), .AwMEM(AwMEM),
									.DaSEL, .DbSEL);
	regfile registers (.clk(~clk), .ReadRegister1(Rn), .ReadRegister2(Ab), 
		.WriteRegister(Rd), .WriteData(Dw), .ReadData1(Da), .ReadData2(Db), .RegWrite);
endmodule
