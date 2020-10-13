// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 10/13/20
// Lab 1 decoder.sv

// Input with a write-enable signal (regWrite) and a select-signal (writeRegister)
// Outputs a 31-bit regEnable that selects the specific register.
module decoder #(parameter HEIGHT=31) (regWrite, writeRegister, regEnable);
	input logic regWrite;
	input logic [4:0] writeRegister;
	output logic [HEIGHT-1:0] regEnable; //30 enable wires
	
	assign regEnable = (1 & regWrite)<< (writeRegister-1); //is this allowed?
endmodule

// Simulates the decoder I/O
`timescale 1 ps / 1 ps
module decoder_testbench #(parameter HEIGHT=31) ();
	
	logic regWrite, clk;
	logic [4:0] writeRegister;
	logic [HEIGHT-1:0] regEnable; //30 enable wires
	
	decoder dut (.*);
	
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