// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/21/20
// Lab 2 ALU top level module and testbench

// ALU with two 64-bit inputs and 3-bit control signal. 
// Output 64-bit result after operations
// Four flags (zero, carry out, overflow, negative)


// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant


module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic		[63:0]	A, B;
	input logic		[2:0]		cntrl;
	output logic		[63:0]	result;
	output logic					negative, zero, overflow, carry_out ;
	logic [63:0] AB_Adder, AandB, AorB, AxorB;							//all results
	logic neg_Adder, neg_AandB, neg_AorB, neg_AxorB; 		//all negative flags
	logic zero_Adder, zero_AandB, zero_AorB, zero_AxorB, zero_B;	//all zero flags
	logic over_Adder;	//all overflow flags
	logic cout_Adder;	//all carryout flags
	
	//MUXes to select which output result is connected to overall output result
	genvar i;
	generate 
		for( i = 0; i < 64; i++)begin: buildMUX
			mux8x1 resultControlMUX (.selector(cntrl), .in({1'b0, AxorB[i], AorB[i], 
				AandB[i], AB_Adder[i], AB_Adder[i], 1'b0, B[i]}), .out(result[i]));
		end
	endgenerate
	
	//MUXes to select which flag is connected to overall output flag
	mux8x1 negativeControlMUX(.selector(cntrl), .in({1'b0, neg_AxorB, neg_AorB,
		neg_AandB, neg_Adder, neg_Adder, 1'b0, B[63]}), .out(negative));
	
	mux8x1 zeroControlMUX(.selector(cntrl), .in({1'b0, zero_AxorB, zero_AorB,
		zero_AandB, zero_Adder, zero_Adder, 1'b0, zero_B}), .out(zero));
		
	mux8x1 overControlMUX(.selector(cntrl), .in({1'b0, 1'b0, 1'b0,
		1'b0, over_Adder, over_Adder, 1'b0, 1'b0}), .out(overflow));
		
	mux8x1 coutControlMUX(.selector(cntrl), .in({1'b0, 1'b0, 1'b0,
		1'b0, cout_Adder, cout_Adder, 1'b0, 1'b0}), .out(carry_out));
	
	
	norGate64x1 zeroFlag_B (.in(B), .out(zero_B));			//determine if B is all zero when crtl = 000

	fullAdder64bit fullAdder (.A(A), .B(B), .sel(cntrl[0]), .result(AB_Adder), .overflow(over_Adder), .negative(neg_Adder), .zero(zero_Adder), .carryout(cout_Adder));
	andOp andOperation (.A(A), .B(B), .result(AandB), .negative(neg_AandB), .zero(zero_AandB));
	orOp orOperation (.A(A), .B(B), .result(AorB), .negative(neg_AorB), .zero(zero_AorB));
	xorOp xorOperation (.A(A), .B(B), .result(AxorB), .negative(neg_AxorB), .zero(zero_AxorB));
	
endmodule

// Test bench for ALU
`timescale 1ns/10ps

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.*);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		/*cntrl = ALU_PASS_B;
		for (i=0; i<5; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end*/
		
		/*$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		cntrl = ALU_ADD; //test overflow
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h7FFFFFFFFFFFFFFF;
		#(delay);
		assert(carry_out == 0 && overflow == 1 && negative == 1 && zero == 0);
	
		cntrl = ALU_ADD; //test negative -1 + -2 = -3
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'hFFFFFFFFFFFFFFFE;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFD && carry_out == 1 && overflow == 0 && negative == 1 && zero == 0);
		
		cntrl = ALU_ADD; //test negative -1 + 1 = 0
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 0 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		*/
		/*
		//Test subtract
		cntrl = ALU_SUBTRACT; //test overflow -(max) - 1 = (max) 
		A = 64'h8000000000000000; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h7FFFFFFFFFFFFFFF && carry_out == 1 && overflow == 1 && negative == 0 && zero == 0);
		
		//Test subtract
		cntrl = ALU_SUBTRACT; //test negative 1 - 2 = -1 
		A = 64'h0000000000000001; B = 64'h0000000000000002;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && carry_out == 0 && overflow == 0 && negative == 1 && zero == 0);
		
		//Test subtract
		cntrl = ALU_SUBTRACT; //test carry_out 1 - 2 = -1 
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && carry_out == 0 && overflow == 1 && negative == 1 && zero == 0);
		
		//Test subtract
		cntrl = ALU_SUBTRACT; //test zero 1 - 1 = 0 
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		*/
		
		//Test and
		cntrl = ALU_AND; //test and 0 and (max)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0;
		#(delay);
		assert(result == 64'h0 && negative == 0 && zero == 1);
		
		cntrl = ALU_AND; //test and 0 and (max)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000001 && negative == 0 && zero == 0);
		
		cntrl = ALU_AND; 
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h8000000000000000 && negative == 1 && zero == 0);
		
		//Test or
		cntrl = ALU_OR; //test and 0 and (max)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && negative == 1 && zero == 0);
		
		cntrl = ALU_OR; 
		A = 64'h0000000000000000; B = 64'h0000000000000000;
		#(delay);
		assert(result == 64'h0000000000000000 && negative == 0 && zero == 1);
		
		//Test xor
		cntrl = ALU_XOR; //test and 0 and (max)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'hFFFFFFFFFFFFFFFF;
		#(delay);
		assert(result == 64'h0 && negative == 0 && zero == 1);
		
		cntrl = ALU_XOR; //test and 0 and (max)
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFE && negative == 1 && zero == 0);
	end
endmodule
