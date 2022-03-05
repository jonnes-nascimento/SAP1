`include "const.v"

module MEM
	
	#(
		parameter DATA_WIDTH =`DATA_W, 
		parameter ADDR_WIDTH =`ADDR_W,
		parameter ROM_FILE   = "rom/program.rom" 
	)
	
	(
		input [(ADDR_WIDTH-1):0] ADDR,
		output [(DATA_WIDTH-1):0] Q
	);

	// Declare the ROM variable
	reg [(DATA_WIDTH-1):0] rom[0:(2**ADDR_WIDTH-1)];

	// Initialize the ROM with $readmemh. Put the memory contents
	// in the file ROM_FILE. Without this file,
	// this design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.
	
	/*
		//Declarando memória ROM por array ===============================
		initial begin
			rom[00] = 8'h18;
			rom[01] = 8'h29;
			rom[02] = 8'h70;
			rom[03] = 8'h00;
			rom[04] = 8'h00;
			rom[05] = 8'h00;
			rom[06] = 8'h00;
			rom[07] = 8'h00;
			rom[08] = 8'h01;
			rom[09] = 8'h02;
			rom[10] = 8'h03;
			rom[11] = 8'h04;
			rom[12] = 8'h05;
			rom[13] = 8'h06;
			rom[14] = 8'h07;
			rom[15] = 8'h08;
		end
		
		assign Q = rom[ADDR];
		
		//Usando case para criar a ROM ===================================

		always @(*) begin
			case(ADDR)
				00: case_rom <= 8'h18;
				01: case_rom <= 8'h29;
				02: case_rom <= 8'h70;
				03: case_rom <= 8'h00;
				04: case_rom <= 8'h00;
				05: case_rom <= 8'h00;
				06: case_rom <= 8'h00;
				07: case_rom <= 8'h00;
				08: case_rom <= 8'h01;
				09: case_rom <= 8'h02;
				10: case_rom <= 8'h03;
				11: case_rom <= 8'h04;
				12: case_rom <= 8'h05;
				13: case_rom <= 8'h06;
				14: case_rom <= 8'h07;
				15: case_rom <= 8'h08;
			endcase;
		end

		assign Q = case_rom;
	*/

	initial begin
		$readmemh(ROM_FILE, rom);
	end
	
	assign Q = rom[ADDR];

endmodule
