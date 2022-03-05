module ULA

	// ULA General I/O
	(
		input ADD_SUB, 
		input [7:0] AR, BR,
		output reg [7:0] OUT
	);
	
	// Data Type Definitions
	
	// Data Initialization
	
	// Circuit Implementation
	always @ (*) begin
		
		if (ADD_SUB == 0)
			OUT <= AR + BR;
		else
			OUT <= AR - BR;
			
	end

endmodule
