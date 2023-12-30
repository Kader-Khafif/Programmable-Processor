/*********************************
** 	TCES 330 digital design	**
**		Kader khafif		**
** 	Claas Project: IR		**
** 	Instruction register		**
**					**
*********************************/

// This module defines the Instruction Register

module IR ( Load, Clk, Data, Instruction );
	//parameter N = 15;
	input Load, Clk;
	input logic [15:0] Data;
	output logic [15:0] Instruction;

	always @ (posedge Clk) begin
		if ( Load ) begin		
			Instruction <= Data;
		end
		else begin
			Instruction <= Instruction;
		end
	end
endmodule

//Test bench
module IR_tb ();
	//localparam n = 3;
	logic Load, Clk;
	logic [15:0] Data;
	logic [15:0] Instruction;

	//IR ( Load, Clk, Data, Instruction );
	IR Dut( Clk, Load, Data, Instruction );

	always begin
		Clk = 1; #10;
		Clk = 0; #10;
	end

	initial begin

		Load = 1; Data = 3'd1; #20;	
		Load = 0; Data = 3'd2; #20;
		Load = 1;  #20;
		Load = 0;  #20;
		Load = 1; Data = 3'd4; #20;
		Load = 0;Data = 3'd3; #20;
		Load = 1; Data = 3'd3; #20;

	//$display($time,,," Load = %b", Load,,,, " Data = %b", Data,,, " Instruction = %d", Instruction);
	$stop;
	end
	initial
	$monitor($time,,," Load = %b", Load,,,, " Data = %b", Data,,, " Instruction = %d", Instruction);
endmodule
