
// Defines

`ifndef CONST_V

	`define CONST_V
	
		// BUS Width
		`define DATA_W 8
		`define ADDR_W 4
	
		// BUS
		`define ALU_IDX_BUS 0
		`define PC_IDX_BUS  1
		`define IR_IDX_BUS  2
		`define AR_IDX_BUS  3
		`define MEM_IDX_BUS 4

		// Control Word
		`define L_PC    11
		`define EN_PC   10
		`define L_MAR   9
		`define EN_MEM  8
		`define L_IR    7
		`define EN_IR   6
		`define L_BR    5
		`define L_OUT   4
		`define EN_AR   3
		`define L_AR    2
		`define ADD_SUB 1 // ~ADD_SUB
		`define EN_ALU  0

`endif