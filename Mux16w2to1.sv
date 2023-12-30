//Thomas Halford/Kader Khafif, TCES 330
//Spring 2022, 05/31/2022
//Final Project
//16-bit wide 2 to 1 MUX

module Mux16w2to1(RFSelect, ALUQ, ReadData, WriteData);

	input RFSelect; //input select signals
	input [15:0] ALUQ, ReadData; //16-bit inputs
	output logic [15:0] WriteData; //output signal
	
	//expressing output WriteData as a boolean expression
	always @(RFSelect, ALUQ, ReadData) begin

	case(RFSelect)

	1'b0 : WriteData = ALUQ;
	1'b1 : WriteData = ReadData;

	endcase

	end

endmodule 

module Mux16w2to1_tb();

	logic RFSelect; //input select signals
	logic [15:0] ALUQ, ReadData; //16-bit inputs
	logic [15:0] WriteData; //output signal
	
	//instantiation of Mux2to1 module
	Mux16w2to1 MUX1(RFSelect, ALUQ, ReadData, WriteData);

	initial begin

	for(int i = 0; i < 20; i++) begin

		RFSelect = $random;
		ALUQ = $random;
		ReadData = $random;
		#20;

		$display($time,,,RFSelect,,,ALUQ,,,ReadData,,,WriteData);
	
	end
	
	end
endmodule
