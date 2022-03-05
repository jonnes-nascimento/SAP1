//-------------------------------------------------------------------
// TITLE: Framework Mercurio IV
// AUTHOR: Leandro Poloni Dantas (leandro.poloni@sp.senai.br)
// DATE CREATED: 11/02/22
// FILENAME: Framework_MercurioIV.v
// PROJECT: Framework_MercurioIV
// COPYRIGHT: Software placed into the public domain by the author.
//    Software 'as is' without warranty.  Author liable for nothing.
// DESCRIPTION:
//    This module combines the pinout of Mercurio IV development kit.
//-------------------------------------------------------------------

module Framework_MercurioIV
	// Decalração de parâmetros
	#(parameter 
		MIN_COUNT 			= 0,
//		MAX_COUNT_1Hz 		= 25_000_000,
//		MAX_COUNT_10Hz		= 25_000_00,
//		MAX_COUNT_100Hz 	= 25_000_0,
//		MAX_COUNT_1kHz 	= 25_000
		// Somente para simulação
		MAX_COUNT_1Hz 		= 10,
		MAX_COUNT_10Hz		= 8,
		MAX_COUNT_100Hz 	= 6,
		MAX_COUNT_1kHz 	= 4
	)
	
	// Declaração de ports
	(
		input 			CLOCK_50MHz,
		input[3:0] 		SW,
		input[11:0]		KEY,
		// Interface UART
		output 			UART_TXD,
		// LED RGB
		output 			LED_R,
		output 			LED_G,
		output 			LED_B,
		// LCD
		inout[7:0] 		LCD_D,	// LCD data is a bidirectional bus
		output 			LCD_RS,	// LCD register select
		output 			LCD_RW,	// LCD Read / nWrite
		output 			LCD_EN,	// LCD Enable
		output 			LCD_BACKLIGHT,
		// Matriz de LEDs
		output[4:0]		LEDM_C,
		output[7:0]		LEDM_R,
		// Display de 7 segmentos
		output[7:0]		DISP0_D,
		output[7:0]		DISP1_D,
		// Placa expansora com 16 chaves
		input[15:0]		GPIO0_D
	);

	// Declaração de tipos de dados
	wire 					RESET;
	wire 					RESET_N;
	reg 					CLK_1Hz;
	reg 					CLK_10Hz;
	reg 					CLK_100Hz;
	reg 					CLK_1kHz;
	wire[3:0] 			SOMA1;
	wire[3:0] 			SOMA2;
	wire[3:0] 			RESULTADO;

	// Funcionamento do circuito
	
	// INSTANCIAÇÃO DOS MÓDULOS ============================
	
	// Sincronizador de reset
	reset_sync reset_synch_50mhz_inst
	(
		.i_clk(CLOCK_50MHz),
		.i_external_reset_n(SW[3]),
		.o_reset(RESET),
		.o_reset_n(RESET_N)
	);
	
	// SAP1 
	SAP1 SAP1
	(
		.MR(RESET),
		.CK(CLK_1Hz),
		.DISPLAY(DISP1_D)
	);
	
	// FIM INSTANCIAÇÃO DOS MÓDULOS ========================
			
	// ALWAYS ==============================================

	// Divide o clock de 50 MHz por n [usa contadores]
	always @(posedge CLOCK_50MHz, posedge RESET)
	begin
		//Variáveis locais
		integer cnt1;			// Faixa MIN_COUNT a MAX_COUNT_1Hz
		integer cnt10;		   // Faixa MIN_COUNT a MAX_COUNT_10Hz
		integer cnt100;	   // Faixa MIN_COUNT a MAX_COUNT_100Hz
		integer cnt1k;		   // Faixa MIN_COUNT a MAX_COUNT_1kHz

		if(RESET)
		begin
			// Reseta os divisores de clock
			cnt1			<= MIN_COUNT;
			cnt10 		<= MIN_COUNT;
			cnt100 		<= MIN_COUNT;
			cnt1k 		<= MIN_COUNT;
			
			// Força o sinal de clock em zero
			CLK_1Hz	 	<= 0;
			CLK_10Hz	 	<= 0;
			CLK_100Hz 	<= 0;
			CLK_1kHz	 	<= 0;
		end
		else
		begin
			// Se chegar no valor máximo
			if(cnt1 != MAX_COUNT_1Hz)
				// Incrementa os contadores
				cnt1 <= cnt1 + 1;
			else
			begin
				// Inicia a contagem
				cnt1 <= MIN_COUNT;
				// Inverte o sinal de clock
				CLK_1Hz <= ~CLK_1Hz;
			end
			
			// Se chegar no valor máximo
			if(cnt10 != MAX_COUNT_10Hz)
				// Incrementa os contadores
				cnt10 <= cnt10 + 1;
			else
			begin
				// Inicia a contagem
				cnt10 <= MIN_COUNT;
				// Inverte o sinal de clock
				CLK_10Hz <= ~CLK_10Hz;
			end
			
			// Se chegar no valor máximo
			if(cnt100 != MAX_COUNT_100Hz)
				// Incrementa os contadores
				cnt100 <= cnt100 + 1;
			else
			begin
				// Inicia a contagem
				cnt100 <= MIN_COUNT;
				// Inverte o sinal de clock
				CLK_100Hz <= ~CLK_100Hz;
			end
			
			// Se chegar no valor máximo
			if(cnt1k != MAX_COUNT_1kHz)
				// Incrementa os contadores
				cnt1k <= cnt1k + 1;
			else
			begin
				// Inicia a contagem
				cnt1k <= MIN_COUNT;
				// Inverte o sinal de clock
				CLK_1kHz <= ~CLK_1kHz;
			end
		end
	end
	
	// FIM AYWAYS ==========================================
	
	// LÓGICA COMBINACIONAL ================================
	
	//Teste clock
	assign DISP0_D[0] = CLK_1Hz;
	assign DISP0_D[6] = CLK_10Hz;
	assign DISP0_D[3] = CLK_100Hz;
	assign DISP0_D[7] = CLK_1kHz;
	
	//Teste das chaves
//	assign DISP1_D[0] = SW[0];
//	assign DISP1_D[1] = SW[1];
//	assign DISP1_D[2] = KEY[0];
//	assign DISP1_D[3] = KEY[1];
//	assign DISP1_D[4] = GPIO0_D[0];
//	assign DISP1_D[5] = GPIO0_D[1];
//	assign DISP1_D[6] = GPIO0_D[2];
//	assign DISP1_D[7] = GPIO0_D[3];
//	
	//Teste reset
	assign LED_R = RESET;
	assign LED_G = RESET_N;
	
	// FIM LÓGICA COMBINACIONAL ============================

endmodule
