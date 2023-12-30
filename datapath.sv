//Thomas Halford/Kader Khafif, TCES 330
//Spring 2022, 05/31/2022
//Final Project
//Datapath module that implements the Data Memory, 
//the 2-1 Mux, the Register file, and the ALU modules

module datapath
	(Clk, //Clock Signal
	DAddr, //Address of DRAM
	DWrite, //Determines if the DRAM is writing or reading
	RFSelect, //Register file select bit
	WriteAddr, //Writing address of RF
	RFWriteEnable, //Determines if RF is writing
	ReadAddrA, //Reading address of A
	ReadAddrB, //Reading address of B
	ALUSelect, //Select bit of ALU
	ALUinA, //ALU A input
	ALUinB, //ALU B input
	ALUout); //ALU output

	input Clk; //Clock signal
	input DWrite; //Determines if the DataMemory is writing or reading
	input RFSelect; //Select bit of the Register File
	input RFWriteEnable; //Enables the Register File to be written to
	input [7:0] DAddr; //Data Memory Address
	input [3:0] ReadAddrA; //Address of A in the RF
	input [3:0] ReadAddrB; //Address of B in the RF
	input [3:0] WriteAddr; //Address of the value being written to the RF
	input [2:0] ALUSelect; //Determines the operation performed by the ALU

	output [15:0] ALUinA; //A input to ALU
	output [15:0] ALUinB; //B input to ALU
	output [15:0] ALUout; //Output of ALU

	logic [15:0] ALUQ; //Wire from the output of the ALU
	logic [15:0] ReadData; //Wire with value taken from Data Memory during load instruction
	logic [15:0] WriteData; //Wire with value written to the RF from the MUX
	logic [15:0] ALUAIn; //Wire from the RF to the A input of the ALU
	logic [15:0] ALUBIn; //Wire from the RF to the A input of the ALU

	assign ALUout = ALUQ; //Assigns the ALU output of the datapath to the output wire of the ALU 
	assign ALUinA = ALUAIn; //Assigns the ALU A input of the datapath to the A input wire of the ALU
	assign ALUinB = ALUBIn; //Assigns the ALU B input of the datapath to the B input wire of the ALU

	//DataMem (address, clock, data, wren, q);
	DataMem D1(.address(DAddr), .clock(Clk), .data(ALUAIn), .wren(DWrite), .q(ReadData));
	
	//Mux16w2to1(RFSelect (S), ALUQ (X), ReadData (Y), WriteData (M));
	Mux16w2to1 MUX(.RFSelect(RFSelect), .ALUQ(ALUQ), .ReadData(ReadData), .WriteData(WriteData));
	
	//regfile16x16a(clk, WriteEnable, WAddr, WData, RAddrA, RDataA, RAddrB, RDataB);
	regfile16x16a REGFILE(.clk(Clk), .WriteEnable(RFWriteEnable), .WAddr(WriteAddr), .WData(WriteData), .RAddrA(ReadAddrA), .RDataA(ALUAIn), .RAddrB(ReadAddrB), .RDataB(ALUBIn));
	
	//ALU(A, B, Sel, Q);
	ALU ALU1(.A(ALUAIn), .B(ALUBIn), .Sel(ALUSelect), .Q(ALUQ));
	
endmodule

//Testbench
`timescale 1 ps / 1 ps
module datapath_tb();

	logic Clk, DWrite, RFSelect, RFWriteEnable;
	logic [7:0] DAddr;
	logic [3:0] ReadAddrA, ReadAddrB, WriteAddr;
	logic [2:0] ALUSelect;	

	logic [15:0] ALUinA;
	logic [15:0] ALUinB;
	logic [15:0] ALUout;

	//logic [15:0] ALUQ, ReadData, WriteData, ALUAIn, ALUBIn;

	datapath DATAPATH(Clk, 
	DAddr, 	
	DWrite, 
	RFSelect, 
	WriteAddr, 
	RFWriteEnable, 
	ReadAddrA, 
	ReadAddrB, 
	ALUSelect, 
	ALUinA, 
	ALUinB, 
	ALUout);

	always begin

	//50 MHz Clock
	Clk = 0; #10;
	Clk = 1; #10;

	end

	initial begin

	//Load 1: RF[0] = D[0]
	//Load 2: RF[1] = D[1]
	//Add 3: RF[2] = RF[0] + RF[1]
	//Store 4: D[9] = RF[2]
	//Sub 5: RF[3] = RF[0] - RF[1]
	//Store 6: D[10] = RF[3]		

	//Load 1: RF[0] = D[0]
	//Load from DRAM (Load A)
	@(negedge Clk) begin
	DAddr = 8'h0;
	RFSelect = 1'b1;
	WriteAddr = 4'b0;
	end
	
	//Write to RF (Load B)
	@(negedge Clk) begin
	RFWriteEnable = 1'b1;
	DAddr = 8'h0;
	RFSelect = 1'b1;
	WriteAddr = 4'b0;
	end
	
	//Display the value loaded into the RF
	@(posedge Clk) #2 $display($time,,,"Data loaded into RF[%h] = %d",WriteAddr, DATAPATH.ReadData); 

	//Load 2: RF[1] = D[1]
	//Load from DRAM (Load A)
	@(negedge Clk) begin
	DAddr = 8'd1;
	RFSelect = 1'b1;
	WriteAddr = 4'b1;
	end

	//Write to RF (Load B)
	@(negedge Clk) begin
	RFWriteEnable = 1'b1;
	DAddr = 8'd1;
	RFSelect = 1'b1;
	WriteAddr = 4'b1;
	end

	//Display the value loaded into the RF
	@(posedge Clk) #2 $display($time,,,"Data loaded into RF[%h] = %d",WriteAddr, DATAPATH.ReadData);

	//Add 3: RF[2] = RF[0] + RF[1]
	@(negedge Clk) begin
	ALUSelect = 3'b001; //Addition
	WriteAddr = 4'b0010; //2
	RFWriteEnable = 1'b1;
	ReadAddrA = 4'b0000; //0
	ReadAddrB = 4'b0001; //1
	RFSelect = 1'b0;
	end

	//Display the values loaded into the ALU and the ALU output
	@(posedge Clk) #2 $display($time,,,"%d +",ALUinA,"%d =",ALUinB,"%d",ALUout);

	//Sub 4: RF[3] = RF[0] - RF[1]
	@(negedge Clk) begin
	ALUSelect = 3'b010; //Subtraction
	WriteAddr = 4'b0011; //3
	RFWriteEnable = 1'b1;
	ReadAddrA = 4'b0000; //0
	ReadAddrB = 4'b0001; //1
	RFSelect = 1'b0;
	end

	//Display the values loaded into the ALU and the ALU output
	@(posedge Clk) $display($time,,,"%d -", ALUinA,"%d =", ALUinB,"%d", ALUout);

	//Store 5: D[9] = RF[2]
	@(negedge Clk) #40; begin
	ReadAddrA = 4'b0010; //0
	DWrite = 1'b1;
	DAddr = 8'd9; //9
	end

	//Display the value written to the DRAM
	@(posedge Clk) #40; $display($time,,,"Value written to the D[%h] = %d", DAddr, DATAPATH.ALUAIn);

	//Store 6: D[10] = RF[1]
	@(negedge Clk) #40; begin
	ReadAddrA = 4'b0011; //3
	DWrite = 1'b1;
	DAddr = 8'd10; //10
	end
		
	//Display the value written to the DRAM
	@(posedge Clk) #20; $display($time,,,"Value written to the D[%h] = %d", DAddr, DATAPATH.ALUAIn); #20;

	$stop;
	
	end

endmodule
