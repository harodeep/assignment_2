`timescale 1ns/1ps

module barrel_shifter (
	input  [3:0] data,
	input  [1:0] shamt,
	input  dir,
	input  rotate,
	output reg [3:0] y
);
	
	always@(*) begin
		if (rotate) begin
			if (dir) y = (data >> shamt) | (data << (4-shamt));
			else y = (data << shamt) | (data >> (4-shamt));
		end else begin
			if (dir) y = data >> shamt;
			else  y = data << shamt;
		end
	
	end

endmodule