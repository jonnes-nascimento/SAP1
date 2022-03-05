module Registrador

	// Registrador general I/O
	#(parameter
		DATA_SIZE = 8
	)
	
	(
		input MR, CK, LOAD,
		input [DATA_SIZE-1 : 0] DATA_IN,
		output reg [DATA_SIZE-1 : 0] DATA_OUT
	);
	
	// Data types definitions
	
	// Circuit implementation
	always @ (posedge CK or negedge MR) begin
		
		if (~MR) begin
			DATA_OUT <= 0;
		end
		else begin
			if (LOAD) begin
				DATA_OUT <= DATA_IN;
			end
		end

	end

endmodule
