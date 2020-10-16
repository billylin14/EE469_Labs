// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/14/20
// Lab 1 regfile.sv

// Input with a clock, three 5-bit register select signals, three 64-bit data buses, and an enable signal to write the registers,
// Creates a 32x64 register that stores 32 lines of 64-bit data, writes one 64-bit data, and reads two lines of 64-bit data.
module regfile (clk, ReadRegister1, ReadRegister2, 
	WriteRegister, WriteData, ReadData1, ReadData2, RegWrite);
	
	input logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 			RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	
	logic [31:0] regEn;
	logic [63:0] regData [31:0];
	logic [31:0] muxTemp [63:0];
	
	decoder5x32 masterDecoder (.regWrite(RegWrite), 
										.writeRegister(WriteRegister), .regEnable(regEn));
	
	genvar i;
	generate
		for (i = 0; i < 31; i++)begin: stackReg
			register regs (.wrData(WriteData), .dOut(regData[i]), .reset(0), .clk, .wrEn(regEn[i]));
		end
	endgenerate
	
	always_comb begin
		regData[31] = 64'b0;
		//transposing data to get 64 of 31s
		for (int k = 0; k < 32; k++) begin
			for (int l = 0; l < 64; l++)
				muxTemp[l][k] = regData[k][l];
		end
	end
	
	genvar j;
	generate 
		for (j = 0; j < 64; j++) begin: stackMux1
			mux32x1 mux1 (.select(ReadRegister1), .in(muxTemp[j][31:0]), .out(ReadData1[j]));
			mux32x1 mux2 (.select(ReadRegister2), .in(muxTemp[j][31:0]), .out(ReadData2[j]));
		end
	endgenerate
endmodule
	
// Test bench for Register file
`timescale 1ns/10ps

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule
