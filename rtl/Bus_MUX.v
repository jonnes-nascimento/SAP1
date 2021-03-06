`include "const.v"

module Bus_MUX

	// MUX General I/O
	(
		input [11:0] CONTROL_WORD, 
		input [7:0] BUS_ALU, BUS_IR, BUS_AR, BUS_PC, BUS_MEM,
		output reg [7:0] BUS_OUT
	);
	
	// Constants
	
	// Data Type Definitions
	
	// Data Initialization
	
	// Circuit Implementation
	always @ (*) begin
	
		if (CONTROL_WORD[`EN_ALU]) begin
			BUS_OUT = BUS_ALU;
		end
		else if (CONTROL_WORD[`EN_IR]) begin
			BUS_OUT = BUS_IR;
		end
		else if (CONTROL_WORD[`EN_AR]) begin
			BUS_OUT = BUS_AR;
		end
		else if (CONTROL_WORD[`EN_PC]) begin
			BUS_OUT = BUS_PC;
		end
		else if (CONTROL_WORD[`EN_MEM]) begin
			BUS_OUT = BUS_MEM;
		end
		else begin
			BUS_OUT = 8'hZZ;
		end
	end

endmodule
