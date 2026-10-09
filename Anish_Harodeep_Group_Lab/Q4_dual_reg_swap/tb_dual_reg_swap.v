`timescale 1ns/1ps

module tb_dual_reg_swap;
    reg        clk;
    reg        rst_n;
    reg        freeze;
    reg        swap;
    reg  [7:0] din;
    wire [7:0] A;
    wire [7:0] B;

    dual_reg_swap uut (
        .clk(clk),
        .rst_n(rst_n),
        .freeze(freeze),
        .swap(swap),
        .din(din),
        .A(A),
        .B(B)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        freeze = 0;
        swap = 0;
        din = 8'h00;

        $dumpfile("dual_reg_swap.vcd");
        $dumpvars(0, tb_dual_reg_swap);

        #12 rst_n = 1;

        $display("-------------------------------------------------------------------------------");
        $display(" TIME | FREEZE | SWAP | DIN  | REG A | REG B | OPERATION RESULT");
        $display("-------------------------------------------------------------------------------");

        // Normal sequence
        @(negedge clk); din = 8'hAA;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Normal: A gets AA, B gets 00", $time, freeze, swap, din, A, B);

        @(negedge clk); din = 8'hBB;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Normal: A gets BB, B gets previous A (AA)", $time, freeze, swap, din, A, B);

        // Test Freeze: A and B must maintain their values
        @(negedge clk); freeze = 1; din = 8'hCC;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Freeze active: A and B hold", $time, freeze, swap, din, A, B);

        // Test Swap: A and B must swap (A=AA, B=BB)
        @(negedge clk); freeze = 0; swap = 1;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Swap active: A and B exchange", $time, freeze, swap, din, A, B);

        // Test Priority: Freeze + Swap active -> Freeze takes precedence
        @(negedge clk); freeze = 1; swap = 1;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Freeze+Swap: Freeze overrides, holds values", $time, freeze, swap, din, A, B);

        // Resume normal operation
        @(negedge clk); freeze = 0; swap = 0; din = 8'hDD;
        @(posedge clk); #1;
        $display("%4t |   %b    |  %b   |  %h  |  %h   |  %h   | Normal: A gets DD, B gets AA", $time, freeze, swap, din, A, B);

        $display("-------------------------------------------------------------------------------");
        #10 $finish;
    end
endmodule