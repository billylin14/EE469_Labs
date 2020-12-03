// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 PCIncrementor.sv

// Input with control signals,
// Acts as the program counter that outputs the next instruction from the instruction memory (instructmem)
// Increments the program counter by 4 or by the addresses specified by branching instructions.

`timescale 1ns/10ps
module PCIncrementor (
				input logic UncondBrRF, BrTakenRF, clk, reset,
				input logic [18:0] CondAddr19RF, //take delayed val
				input logic [25:0] BrAddr26RF, 	//take delayed val
				input logic [63:0] PCRF,			//old PC val
				output logic [31:0] Instruction,
				output logic [63:0] PCout);
				
	logic [63:0] CondAddr19_SE, BrAddr26_SE, UncondOut, UncondAdderOut,
					 UncondShifted, Adder4Out, BrTakenOut;
	//delayed
	
	se #(19) SE1	(.in(CondAddr19RF),.out(CondAddr19_SE));
	se #(26) SE2 (.in(BrAddr26RF), .out(BrAddr26_SE));
	leftShift multiplyBy4 (.SHAMT(2'b10), .in(UncondOut), .out(UncondShifted));
	fullAdder64bit UncondAdder(.A(UncondShifted), .B(PCRF), .sel(1'b0), //PCout should take the old value PCRF
			.result(UncondAdderOut), .overflow(), .negative(), .zero(), .carryout()); //output flags don't matter
			
	//not delayed
	fullAdder64bit Adder4 (.A(PCout), .B(64'b100), .sel(1'b0), .result(Adder4Out), //PCout is the most recent one
			.overflow(), .negative(), .zero(), .carryout()); //output flags don't matter
	
	genvar i;
	generate
	for (i=0; i<64; i++) begin: build64bitMux
		mux2x1 UncondBrMUX (.selector(UncondBrRF), .in({BrAddr26_SE[i],CondAddr19_SE[i]}), .out(UncondOut[i])); //output to leftShift2
		mux2x1 BrTakenMUX (.selector(BrTakenRF), .in({UncondAdderOut[i], Adder4Out[i]}), .out(BrTakenOut[i])); //output to PC
	end
	endgenerate
	
	pc programCounter (.in(BrTakenOut), .out(PCout), .clk, .reset); //outputs the most recent PC
	
	//ignore
	instructmem instructionMemory (.address(PCout), .instruction(Instruction), .clk);

	
endmodule