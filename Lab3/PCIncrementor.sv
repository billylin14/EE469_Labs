// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 11/10/20
// Lab 3 PCIncrementor.sv

// Input with control signals,
// Acts as the program counter that outputs the next instruction from the instruction memory (instructmem)
// Increments the program counter by 4 or by the addresses specified by branching instructions.

`timescale 1ns/10ps
module PCIncrementor (
				input logic UncondBr, BrTaken, clk, reset,
				input logic [18:0] CondAddr19,
				input logic [25:0] BrAddr26,
				output logic [31:0] Instruction);
				
	logic [63:0] CondAddr19_SE, BrAddr26_SE, UncondOut, UncondAdderOut,
					 UncondShifted, Adder4Out, BrTakenOut, PCout;
				
	se #(19) SE1	(.in(CondAddr19),.out(CondAddr19_SE));
	se #(26) SE2 (.in(BrAddr26), .out(BrAddr26_SE));
	
	leftShift multiplyBy4 (.SHAMT(2'b10), .in(UncondOut), .out(UncondShifted));
	
	fullAdder64bit UncondAdder(.A(UncondShifted), .B(PCout), .sel(1'b0), 
			.result(UncondAdderOut), .overflow(), .negative(), .zero(), .carryout()); //output flags don't matter
	fullAdder64bit Adder4 (.A(PCout), .B(64'b100), .sel(1'b0), .result(Adder4Out),
			.overflow(), .negative(), .zero(), .carryout()); //output flags don't matter
	
	pc programCounter (.in(BrTakenOut), .out(PCout), .clk, .reset);
	
	instructmem instructionMemory (.address(PCout), .instruction(Instruction), .clk);
	
	genvar i;
	generate
	for (i=0; i<64; i++) begin: build64bitMux
		mux2x1 UncondBrMUX (.selector(UncondBr), .in({BrAddr26_SE[i],CondAddr19_SE[i]}), .out(UncondOut[i])); //output to leftShift2
		mux2x1 BrTakenMUX (.selector(BrTaken), .in({UncondAdderOut[i], Adder4Out[i]}), .out(BrTakenOut[i])); //output to PC
	end
	endgenerate
	
	
	
endmodule