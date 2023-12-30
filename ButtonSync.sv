//Thomas Halford/Kader Khafif, TCES 330
//Spring 2022, 05/31/2022
//Final Project
//Button Sync State Machine Ensures a button press is 
//only one clock period long. <Digital Design> by Vahid

module ButtonSync(Bi, Bo, Clk);
  input Bi;        // unregistered input button press
  input Clk;       // system clock
  
  output logic Bo;   // synchronizer output, one clock period long
  
  // State Names
  localparam S_A = 2'h0, 
             S_B = 2'h1,
             S_C = 2'h2;

             
  logic [1:0] State = S_A, NextState;
  
  // CombLogic
  always_comb begin
  
    // default
    Bo = 0;
    NextState = State;
	 
    case ( State )
      
      S_A: begin
        if ( Bi == 1'b1 )
          NextState = S_B;  // button push detected
        else
          NextState = S_A;
      end
      
      S_B: begin
        Bo = 1; // turn output ON
        if ( Bi == 1'b1 )
          NextState = S_C; 
        else
          NextState = S_A;
      end
      
      S_C: begin
        if ( Bi == 1'b1 )
          NextState = S_C;  // stay in this state
        else
          NextState = S_A;  // otherwise, back to A
      end
      
      default: begin  // catch-all
        NextState = S_A;
      end
      
    endcase
  end // always
    
  // StateReg
  always_ff @( posedge Clk ) begin
    State <= NextState;   // go to the state we set
  end  // always
  
endmodule

//********************************************//
//                 Testbench	                //
//********************************************//
module ButtonSync_testbench;
  logic Bi;        // unregistered input button press
  logic Clock;     // system clock
  logic Bo;        // output signal
	
  // module under test:
  // reference: ButtonSync( Bi, Bo, Clk );
  ButtonSync DUT( Bi, Bo, Clock );
  
  // develop a clock (50 MHz)
  always begin
    	Clock <= 0;
    	#10;
    	Clock <= 1;
    	#10;
    end  
  
  initial	// Test stimulus
    begin
      Bi = 0;
      #100 Bi = 1'b1;
      #110 Bi = 0;
      #100 $stop;
    end
    
    // view waveforms
      
endmodule     
	
  