// Test bench for ALU
`timescale 1ns/10ps

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

module alu(A, B, cntrl, result, negative, zero, overflow, carryout)
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
		for( i = 0; i < 64; i++): begin buildMUX
			mux8x1 resultControlMUX (.selector(cntrl), .in({B[i], 0, AB_Adder[i], 
				AB_Adder[i], AandB[i], AorB[i], AxorB[i], 0}), .out(result[i]));
		end
	endgenerate
	
	//MUXes to select which flag is connected to overall output flag
	mux8x1 negativeControlMUX(.selector(cntrl), .in({B[63], 0, neg_Adder,
		neg_Adder, neg_AandB, neg_AorB, neg_AxorB, 0}), .out(negative));
	
	mux8x1 zeroControlMUX(.selector(cntrl), .in({zero_B, 0, zero_Adder,
		zero_Adder, zero_AandB, zero_AorB, zero_AxorB, 0}), .out(zero));
		
	mux8x1 overControlMUX(.selector(cntrl), .in({0, 0, over_Adder,
		over_Adder, 0, 0, 0, 0}), .out(overflow));
		
	mux8x1 coutControlMUX(.selector(cntrl), .in({0, 0, over_Adder,
		over_Adder, 0, 0, 0, 0}), .out(carryout));
	
	
	norGate64x1 zeroFlag_B (.in(B), .out(zero_B));			//determine if B is all zero when crtl = 000

	fullAdder64bit fullAdder (.A(A), .B(B), .sel(cntrl[0]), .result(AB_Adder), .overflow(over_Adder), .negative(neg_Adder), .zero(zero_Adder), .carryout(cout_Adder));
	andOp andOperation (.A(A), .B(B), .result(AandB), .negative(neg_AandB), .zero(zero_AandB));
	orOp orOperation (.A(A), .B(B), .result(AorB), .negative(neg_AorB), .zero(zero_AorB));
	xorOp xorOperation (.A(A), .B(B), .result(AxorB), .negative(neg_AxorB), .zero(zero_AxorB));

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
	end
endmodule
