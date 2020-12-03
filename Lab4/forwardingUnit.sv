//Place inside of Cameron CPU?
module forwardingUnit ( input logic [4:0] AaRF, AbRF, AwEX, AwMEM,
								output logic [1:0] DaSEL, DbSEL);
	always_comb begin
		if (AaRF == AwEX)			begin				DaSEL = 2'b0; end
		else if (AaRF == AwMEM)	begin	 			DaSEL = 2'b01;end
		else 							begin				DaSEL = 2'b10;end
		
		if (AbRF == AwEX) 		begin				DbSEL = 2'b0; end
		else if (AbRF == AwMEM)	begin				DbSEL = 2'b01;end
		else 							begin				DbSEL = 2'b10;end
	end
	
endmodule
