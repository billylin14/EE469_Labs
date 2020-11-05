//Acts as the program counter able to branch and increment instruction register by 4

`timescale 1ns/10ps
module PCIncrementor (
				input logic UncondBr, BrTaken, clk, reset,
				input logic [18:0] CondAddr19,
				input logic [25:0] BrAddr26,
				output logic [31:0] Instruction);
				
	logic [63:0] CondAddr19_SE, BrAddr26_SE, UncondOut, UncondAdderOut,
					 UncondShifted, Adder4Out, BrTakenOut, PCout;
				
	//se #(19) SE1	(.in(CondAddr19),.out(CondAddr19_SE));
	//se #(26) SE2 (.in(BrAddr26), .out(BrAddr26_SE));
	
	leftShift2 (.in(UncondOut), .out(UncondShifted));
	
	fullAdder64bit UncondAdder(.A(UncondShifted), .B(PCout), .sel(0), 
			.result(UncondAdderOut), .overflow(), .negative(), .zero(), .carryout());
	fullAdder64bit Adder4 (.A(PCout), .B(64'b100), .sel(0), .result(Adder4Out)
			.overflow(), .negative(), .zero(), .carryout());
	
	pc programCounter (.in(BrTakenOut), .out(PCout), .clk, .reset);
	
	instructmem instructionMemory (.address(PCout), .instruction(Instruction), .clk);
	
	genvar i;
	generate
	for (i=0; i<64; i++) begin: build64bitMux
		//mux2x1 UncondBrMUX (.selector(UncondBr), .in({BrAddr26_SE[i],CondAddr19_SE[i]}, .out(Uncondout[i]));
		//mux2x1 BrTakenMUX (.selector(BrTaken), .in({UncondAdderOut[i], Adder4Out[i]}), .out(BrTakenOut[i]));
	end
	endgenerate
	
	
	
endmodule