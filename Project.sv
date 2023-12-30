//Thomas Halford/Kader Khafif, TCES 330
//Spring 2022, 05/31/2022
//Final Project
//Top-Level module for final Project that instantiates 
//the processor module to interface with the DE2 board

module Project(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, CLOCK_50, LEDG, LEDR);

	input [17:0] SW;
	input CLOCK_50;
	input [3:0] KEY;
	
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	output [17:0] LEDR;
	output [3:0] LEDG;
	
	logic [15:0] ALU_A, ALU_B, ALU_Out, IR_Out, M;
	logic [7:0] PC_Out;
	logic [3:0] NextStateOut, StateOut;
	logic Bo, KeyOut, Strobe;
	
	assign LEDR = SW;
	assign LEDG = ~KEY;
	
	//KeyFilter(Clock, In, Out, Strobe);
	KeyFilter KEYF(CLOCK_50, Bo, KeyOut, Strobe);
	
	//Processor(Clk, Reset, IR_Out, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out);
	Processor P1(KeyOut, ~KEY[1], IR_Out, PC_Out, StateOut, NextStateOut, ALU_A, ALU_B, ALU_Out);

	//ButtonSync(Bi, Bo, Clk);
	ButtonSync BUTTON(KEY[2], Bo, CLOCK_50);
	
	//Mux8to1(S, A, B, C, D, E, F, G, H, V);
	Mux8to1 MUX8(SW[17:15], {PC_Out, 4'b0, StateOut}, ALU_A, ALU_B, ALU_Out, {12'b0, NextStateOut}, 16'h0, 16'h0, 16'h0, M);
	
	//Decoder(X, Y);
	Decoder H0(IR_Out[3:0], HEX0);
	Decoder H1(IR_Out[7:4], HEX1);
	Decoder H2(IR_Out[11:8], HEX2);
	Decoder H3(IR_Out[15:12], HEX3);
	Decoder H4(M[3:0], HEX4);
	Decoder H5(M[7:4], HEX5);
	Decoder H6(M[11:8], HEX6);
	Decoder H7(M[15:12], HEX7);
  
endmodule 