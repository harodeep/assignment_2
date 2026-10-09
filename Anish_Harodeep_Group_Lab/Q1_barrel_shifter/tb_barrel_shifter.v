`timescale 1ns/1ps

module tb_barrel_shifter;
    reg  [3:0] din;
    reg  [1:0] amt;
    reg  [1:0] mode;
    wire [3:0] dout;

    barrel_shifter_4bit uut (
        .din(din),
        .amt(amt),
        .mode(mode),
        .dout(dout)
    );

    initial begin
        $dumpfile("barrel_shifter.vcd");
        $dumpvars(0, tb_barrel_shifter);

        $display("---------------------------------------------------------------");
        $display(" TIME | DIN  | MODE | AMT | DOUT | OPERATION DESCRIPTION");
        $display("---------------------------------------------------------------");

        din = 4'b1101;

        // Mode 00: SHL
        mode = 2'b00; amt = 2'd0; #10;
        $display("%4t | %b |  %b  |  %d  | %b | SHL by 0 (Expected: 1101)", $time, din, mode, amt, dout);
        mode = 2'b00; amt = 2'd1; #10;
        $display("%4t | %b |  %b  |  %d  | %b | SHL by 1 (Expected: 1010)", $time, din, mode, amt, dout);
        mode = 2'b00; amt = 2'd2; #10;
        $display("%4t | %b |  %b  |  %d  | %b | SHL by 2 (Expected: 0100)", $time, din, mode, amt, dout);

        // Mode 01: SHR
        mode = 2'b01; amt = 2'd1; #10;
        $display("%4t | %b |  %b  |  %d  | %b | SHR by 1 (Expected: 0110)", $time, din, mode, amt, dout);
        mode = 2'b01; amt = 2'd2; #10;
        $display("%4t | %b |  %b  |  %d  | %b | SHR by 2 (Expected: 0011)", $time, din, mode, amt, dout);

        // Mode 10: ROL
        mode = 2'b10; amt = 2'd1; #10;
        $display("%4t | %b |  %b  |  %d  | %b | ROL by 1 (Expected: 1011)", $time, din, mode, amt, dout);
        mode = 2'b10; amt = 2'd3; #10;
        $display("%4t | %b |  %b  |  %d  | %b | ROL by 3 (Expected: 1110)", $time, din, mode, amt, dout);

        // Mode 11: ROR
        mode = 2'b11; amt = 2'd1; #10;
        $display("%4t | %b |  %b  |  %d  | %b | ROR by 1 (Expected: 1110)", $time, din, mode, amt, dout);
        mode = 2'b11; amt = 2'd2; #10;
        $display("%4t | %b |  %b  |  %d  | %b | ROR by 2 (Expected: 0111)", $time, din, mode, amt, dout);

        $display("---------------------------------------------------------------");
        $finish;
    end
endmodule