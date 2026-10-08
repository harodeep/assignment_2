`timescale 1ns/1ps

module barrel_shifter (
	input  [3:0] data,
	input  [1:0] shamt,
	input  dir,
	input  rotate,
	output [3:0] y
);

	wire [3:0] rev_in;
	wire [3:0] shift_in;
	wire [3:0] pad_bits;
	wire [7:0] double_data;
	wire [7:0] shifted_full;
	wire [3:0] shifted_out;
	wire [3:0] rev_out;

	assign rev_in = {data[0], data[1], data[2], data[3]};
	assign shift_in  = dir ? data : rev_in;
	
	assign pad_bits = rotate ? shift_in : 4'b0000;
	assign double_data = {pad_bits, shift_in};
	
	assign shifted_full = double_data >> shamt;
	assign shifted_out = shifted_full[3:0];
	
	assign rev_out = {shifted_out[0], shifted_out[1], shifted_out[2], shifted_out[3]};
	assign y = dir ? shifted_out : rev_out;

endmodule