`include "const.v"

module Control_Unit 

	// Control_Unit General Parameters
	#(
		parameter ROM_MICRO_INSTR_FILE_1 = "rom/micro_instr_1.rom", 
		parameter ROM_MICRO_INSTR_FILE_2 = "rom/micro_instr_2.rom"
	)
	
	// Control_Unit General I/O
	(
		input CK, MR, 
		input [(`ADDR_W-1):0] INSTR, 
		output [11:0] CONTROL_WORD
	);
	
	// Data Type Definitions
	reg [(`DATA_W-1):0] rom1[0:2**(`DATA_W-1)];
	reg [(`DATA_W-1):0] rom2[0:2**(`DATA_W-1)];
	reg [2:0] count;
	wire [(`DATA_W-1):0] addr;
	
	// Data Initialization
	initial begin
		$readmemh(ROM_MICRO_INSTR_FILE_1, rom1);
		$readmemh(ROM_MICRO_INSTR_FILE_2, rom2);
	end
	
	// Circuit Implementation
	always @ (posedge CK or posedge MR) begin
		
		if (MR) begin
			count <= 0;
		end
		else if (count == 4) begin
			count <= 0;
		end
		else begin
			count <= count + 1;
		end
		
	end
	
	assign addr = {INSTR[(`ADDR_W-1):0], 1'b0, count[2:0]};
	
	assign CONTROL_WORD = {rom2[addr][3:0], rom1[addr][7:0]};

endmodule

