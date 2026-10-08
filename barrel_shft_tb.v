`timescale 1ns/1ps
module tb_barrel_shifter;
 reg [3:0] data;
 reg [1:0] shamt;
  reg dir;
  reg rotate;
  
  wire [3:0] y;
  
  barrel_shifter dut (
  .data(data),
  .shamt(shamt),
  .dir(dir),
  .rotate(rotate),
  .y(y)
  );
  
  initial begin 
  	$monitor (" data= %b shamt = %b dir = %b rotate=%b y=%b", data ,shamt,dir,rotate,y);
  	
  	data = 4'b1011;
  	// left shift 
  	dir = 0;
  	rotate = 0;
  	shamt= 0;#10;
  	shamt= 1;#10;
  	shamt= 2;#10;
  	shamt= 3;#10;
  	
  		// right shift 
  	dir = 1;
  	rotate = 0;
  	shamt= 0;#10;
  	shamt= 1;#10;
  	shamt= 2;#10;
  	shamt= 3;#10;
  	
  		// left rot 
  	dir = 0;
  	rotate = 1;
  	shamt= 1;#10;
  	shamt= 2;#10;
  	shamt= 3;#10;
  	
  		// right rot
  	dir = 1;
  	rotate = 1;
  	
  	shamt= 1;#10;
  	shamt= 2;#10;
  	shamt= 3;#10;

  $finish;
  end
  

endmodule