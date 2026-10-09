`timescale 1ns/1ps

module tb_clock_gater;
    reg  clk;
    reg  en;
    wire gclk;

    clock_gater uut (
        .clk(clk),
        .en(en),
        .gclk(gclk)
    );

    // 10ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        en  = 0;

        $dumpfile("clock_gater.vcd");
        $dumpvars(0, tb_clock_gater);

        $display("----------------------------------------------------------------------");
        $display(" TIME | CLK | EN | GCLK | BEHAVIOR DESCRIPTION");
        $display("----------------------------------------------------------------------");

        #12; // Clock running, enable is 0
        $display("%4t |  %b  |  %b |  %b   | Clock inactive (gclk held 0)", $time, clk, en, gclk);

        // Turn on enable during low phase of clock
        @(negedge clk);
        #2 en = 1;
        $display("%4t |  %b  |  %b |  %b   | EN asserted during low clock phase", $time, clk, en, gclk);

        #20; // Let multiple gated clock cycles pass

        // Inject hazard: transition enable HIGH-TO-LOW while CLK is HIGH
        @(posedge clk);
        #2 en = 0; // Glitch test: de-asserted mid-clock-pulse
        $display("%4t |  %b  |  %b |  %b   | EN dropped while CLK=1 (Hazard test)", $time, clk, en, gclk);
        #2;
        $display("%4t |  %b  |  %b |  %b   | Verify GCLK stays HIGH (no runt pulse/glitch)", $time, clk, en, gclk);

        @(negedge clk);
        #1;
        $display("%4t |  %b  |  %b |  %b   | CLK falls: GCLK cleanly cuts off", $time, clk, en, gclk);

        #20;
        $finish;
    end
endmodule