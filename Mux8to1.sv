//Thomas Halford/Kader Khafif, TCES 330
//Spring 2022, 05/31/2022
//Final Project
//Module that implements a 16-bit wide 8 to 1 Multiplexer 

module Mux8to1(S, A, B, C, D, E, F, G, H, V);

	input [2:0] S; //select bits
	input [15:0] A, B, C, D, E, F, G, H; //input bits
	output logic [15:0] V; //output bit
	
	always@* begin
	
	case(S)

	3'b000 : V = A;
	3'b001 : V = B;
	3'b010 : V = C;
	3'b011 : V = D;
	3'b100 : V = E;
	3'b101 : V = F;
	3'b110 : V = G;
	3'b111 : V = H;

	endcase

	end

endmodule

//Testbench
module Mux8to1_tb();

	logic [2:0] S; //select bits
	logic [15:0] A, B, C, D, E, F, G, H; //input bits
	logic [15:0] V; //output bit

	//Instantiation of 8 to 1 MUX
	Mux8to1 DUT(S, A, B, C, D, E, F, G, H, V);

	initial begin
	
	//for loop used to cycle through a substantial amount of possible inputs
	//total possible combinations = 2^11 - 1
	for(int i = 0; i < 50; i++) begin

		S = i; //increment S to make reading output easier
		A = $random; //randomize the input
		B = $random; //randomize the input
		C = $random; //randomize the input
		D = $random; //randomize the input
		E = $random; //randomize the input
		F = $random; //randomize the input
		G = $random; //randomize the input
		H = $random; //randomize the input

		#2;
		//displays the select bits, input bits, and output bit
		$display($time,,,"S = %b", S,,,"Inputs (A, B, C, D, E, F, G, H) = %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b", A, B, C, D, E, F, G, H,,,"Output = %b", V); 
	
	end
	
	end

endmodule
