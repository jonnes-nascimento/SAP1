module PC

	// PC General I/O
	(
		input CK, MR, LOAD,
		output [7:0] COUNT_OUT
	);
	
	// Data Type Definitions
	reg [3:0] count;
	
	// Data Initialization
	
	// Circuit Implementation
	always @ (posedge CK or negedge MR) begin
		
		if (MR == 0) begin
			count = 0;
		end
		else if (LOAD) begin
			count <= count + 1;
		end
			
	end
	
	assign COUNT_OUT = {4'b0000, count};

endmodule
