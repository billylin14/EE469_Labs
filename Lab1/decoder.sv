// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/13/20
// Lab 1 decoder.sv

// Input with a write-enable signal (regWrite) and a select-signal (writeRegister)
// Outputs a 31-bit regEnable that selects the specific register.
// Decoder is a 5:32 decoder built from four 3:8 decoders and one 2:4 decoder.
module decoder5x32 #(parameter HEIGHT=32) (regWrite, writeRegister, regEnable);
	input logic regWrite;
	input logic [4:0] writeRegister;
	output logic [HEIGHT-1:0] regEnable; //32 enable wires
	logic [3:0] enabler;  //selects which 3:8 decoder to use
	
	//assign regEnable = (1 & regWrite) << (writeRegister-1); //can't use this
	decoder2x4 selector (.enable(regWrite), .in(writeRegister[4:3]), .out( enabler));
	decoder3x8 decoder0 (.enable(enabler[0]), .in(writeRegister[2:0]), .out(regEnable[7:0])); 
	decoder3x8 decoder1 (.enable(enabler[1]), .in(writeRegister[2:0]), .out(regEnable[15:8])); 
	decoder3x8 decoder2 (.enable(enabler[2]), .in(writeRegister[2:0]), .out(regEnable[23:16]));
	decoder3x8 decoder3 (.enable(enabler[3]), .in(writeRegister[2:0]), .out(regEnable[31:24])); 
	

endmodule


// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder5x32_testbench #(parameter HEIGHT=32) ();
	
	logic regWrite, clk;
	logic [4:0] writeRegister;
	logic [HEIGHT-1:0] regEnable; //30 enable wires
	
	decoder5x32 dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end

	initial begin 
		regWrite <= 0; @(posedge clk);
		regWrite <= 1; writeRegister <= 5; @(posedge clk); 
		regWrite <= 1; writeRegister <= 6; @(posedge clk); 
		regWrite <= 1; writeRegister <= 7; @(posedge clk); 
		regWrite <= 1; writeRegister <= 8; @(posedge clk); 
		regWrite <= 0; @(posedge clk);
		$stop;
	end
endmodule