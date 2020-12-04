// Authors: Billy Lin, Cameron Wutzke
// EE 469 Prof. Scott Hauck
// 
// Lab 4 forwardingUnit.sv

// Input with control signals, register addresses, and data in different stages,
// Decides which data to forward to registers with three selectors.

module forwardingUnit ( input logic MOVsel, load, memWrite, memWriteEX,
								input logic [4:0] AaRF, AbRF, AwEX, AwMEM,
								output logic [1:0] DaSEL, DbSEL, ALUSEL);
	always_comb begin
		if (memWriteEX) 			begin 			DaSEL = 2'b10; end
		else if (AaRF == 5'b11111)	begin			DaSEL = 2'b10; end
		else if (MOVsel && AaRF == AwEX) begin	DaSEL = 2'b11; end
		else if (AaRF == AwEX)	begin				DaSEL = 2'b0;  end
		else if (AaRF == AwMEM)	begin	 			DaSEL = 2'b01; end
		else 							begin				DaSEL = 2'b10; end
		
		if (load | memWrite)		begin				ALUSEL = 2'b10; end
		else if (MOVsel && AaRF == AwEX) begin	ALUSEL = 2'b11; end
		else if (AbRF == 5'b11111)	begin			ALUSEL = 2'b10; end
		else if (AbRF == AwEX)	begin				ALUSEL = 2'b0;  end
		else if (AbRF == AwMEM)	begin				ALUSEL = 2'b01; end
		else 							begin				ALUSEL = 2'b10; end
		
		
		if (memWriteEX) begin 	
			if (AbRF == AwEX) begin 				DbSEL = 2'b11; end
			else begin 									DbSEL = 2'b10; end
		end
		else if (AbRF == 5'b11111)	begin			DbSEL = 2'b10; end
		else if (AbRF == AwEX)	begin				DbSEL = 2'b0;  end
		else if (AbRF == AwMEM)	begin				DbSEL = 2'b01; end
		else 							begin				DbSEL = 2'b10; end
	end
	
endmodule
