`timescale 1ns/10ps
module EX_stage  (input logic clk,
						input logic [63:0] 	Da, Db, ALUin,
						input logic [1:0] 	SHAMT,
						input logic 			setFlag, KZsel, MOVsel,
						input logic [2:0]		ALUop,
						input logic [15:0]		imm16,
						output logic [63:0] 	ALUout, MOVout,
						output logic negative, zero, overflow, carry_out, cbzFlag);
	//Flags
	logic [3:0] flags;					
						
	//ALU		
	alu ALU(.A(Da), .B(ALUin), .cntrl(ALUop), .result(ALUout), .negative(flags[0]), .zero(flags[1]), .overflow(flags[2]), .carry_out(flags[3]));
	
	dff_real negDff (.in(flags[0]), .en(setFlag), .out(negative), .clk);
	dff_real zeroDff (.in(flags[1]), .en(setFlag), .out(zero), .clk);
	dff_real ofDff (.in(flags[2]), .en(setFlag), .out(overflow), .clk);
	dff_real coutDff (.in(flags[3]), .en(setFlag), .out(carry_out), .clk);	
	and #0.05 andZero (cbzFlag, flags[1], setFlag); //accelerated branch - combinational zero flag
	
	//shift logic for MOV
	logic [3:0] shiftSHAMT;
	
	decoder2x4 cntrlSHAMT (.enable(MOVsel), .in(SHAMT), .out(shiftSHAMT));

	//control logics
	logic [63:0] KZin;
	
	genvar i;
	genvar j;
	generate
	for (i=0; i<64; i++)begin: build64BitMux
		mux2x1 KZselector (.selector(KZsel), .in({Da[i], 1'b0}), .out(KZin[i]));
	end
	for (i=0; i<4; i++)begin: movBitSel
		for (j=0; j<16; j++)begin: padMuxes
			mux2x1 movBit (.selector(shiftSHAMT[i]), .in({imm16[j], KZin[16*i+j]}), .out(MOVout[16*i+j]));
		end
	end
	endgenerate
endmodule
