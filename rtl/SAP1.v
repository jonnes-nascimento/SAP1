`include "const.v"

module SAP1 

	// SAP1 General I/O
	(
		input MR, CK,
		output [7:0] DISPLAY,
		output [(`DATA_W-1):0] DBG_BUS,
		output [11:0] DBG_CONTROL_WORD
	);
	
	// Data Types
	wire [11:0] control_word;
	wire [(`DATA_W-1):0] bus;
	wire [(`DATA_W-1):0] bus_mux_array[5];
	wire [(`DATA_W-1):0] mar_bus;
	wire [(`DATA_W-1):0] br_bus;
	
	// Data Initialization
	
	// Circuit implemetation
	
	// BUS Multiplexer
	Bus_MUX bus_mux (
		.CONTROL_WORD(control_word), 
		.BUS_ALU(bus_mux_array[`ALU_IDX_BUS]),
		.BUS_IR(bus_mux_array[`IR_IDX_BUS]), 
		.BUS_AR(bus_mux_array[`AR_IDX_BUS]), 
		.BUS_PC(bus_mux_array[`PC_IDX_BUS]), 
		.BUS_MEM(bus_mux_array[`MEM_IDX_BUS]),
		.BUS_OUT(bus)
	);
	
	// ULA - Aritmethic Logic Unit (ALU)
	ULA ula
	(
		.ADD_SUB(control_word[`ADD_SUB]),
		.AR(bus_mux_array[`AR_IDX_BUS]),
		.BR(br_bus),
		.OUT(bus_mux_array[`ALU_IDX_BUS])
	);
	
	// MAR - Memory Access Register
	Registrador 
	#(	
		.DATA_SIZE(`ADDR_W)
	) 
	mar 
	(
		.MR(!MR), 
		.CK(CK),
		.LOAD(control_word[`L_MAR]),
		.DATA_IN(bus),
		.DATA_OUT(mar_bus)
	);
	
	// IR - Instruction Register
	Registrador 
	#(	
		.DATA_SIZE(`DATA_W)
	) 
	ir 
	(
		.MR(!MR), 
		.CK(CK),
		.LOAD(control_word[`L_IR]),
		.DATA_IN(bus),
		.DATA_OUT(bus_mux_array[`IR_IDX_BUS])
	);
	
	
	// AR - A Register
	Registrador 
	#(	
		.DATA_SIZE(`DATA_W)
	) 
	ar 
	(
		.MR(!MR), 
		.CK(CK),
		.LOAD(control_word[`L_AR]),
		.DATA_IN(bus),
		.DATA_OUT(bus_mux_array[`AR_IDX_BUS])
	);
	
	// BR - B Register
	Registrador 
	#(	
		.DATA_SIZE(`DATA_W)
	) 
	br 
	(
		.MR(!MR), 
		.CK(CK),
		.LOAD(control_word[`L_BR]),
		.DATA_IN(bus),
		.DATA_OUT(br_bus)
	);
	
	// OUTR - Output Register
	Registrador 
	#(	
		.DATA_SIZE(`DATA_W)
	) 
	outr 
	(
		.MR(!MR), 
		.CK(CK),
		.LOAD(control_word[`L_OUT]),
		.DATA_IN(bus),
		.DATA_OUT(DISPLAY)
	);
	
	// PC - Program Counter
	PC	pc
	(
		.CK(!CK),
		.MR(!MR), 
		.LOAD(control_word[`L_PC]),
		.COUNT_OUT(bus_mux_array[`PC_IDX_BUS])
	);
	
	// MEM - Program and Data Memory
	MEM
	#(	
		.ROM_FILE("rom/program.rom"),
		.DATA_WIDTH(`DATA_W),
		.ADDR_WIDTH(`ADDR_W)
	) 
	mem 
	(
		.ADDR(mar_bus[(`ADDR_W-1):0]),
		.Q(bus_mux_array[`MEM_IDX_BUS])
	);
	
	// CONTROL UNIT - Control Unit
	Control_Unit
	#(
		.ROM_MICRO_INSTR_FILE_1("rom/micro_instr_1.rom"), 
		.ROM_MICRO_INSTR_FILE_2("rom/micro_instr_2.rom")
	)
	control_unit
	(
		.CK(!CK), 
		.MR(MR), 
		.INSTR(bus_mux_array[`IR_IDX_BUS][7:4]), 
		.CONTROL_WORD(control_word)
	);
	
	// DEBUG Signals
	assign DBG_BUS = bus;
	assign DBG_CONTROL_WORD = control_word;
	
endmodule
