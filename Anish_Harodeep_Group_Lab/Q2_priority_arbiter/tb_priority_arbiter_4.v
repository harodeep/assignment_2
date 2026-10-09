`timescale 1ns/1ps

module tb_priority_arbiter_4;
    reg        clk;
    reg        rst;
    reg  [3:0] req;
    wire [3:0] grant;

    priority_arbiter_4 uut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .grant(grant)
    );

    // 10ns clock period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        req = 4'b0000;
        #12;
        rst = 0;

        $display("----------------------------------------------------------------");
        $display(" TIME | RST | REQ (X3 X2 X1 X0) | GRANT (G3 G2 G1 G0) | NOTE");
        $display("----------------------------------------------------------------");

        // Test 1: Single request on lowest priority X3
        req = 4'b1000; #10;
        $display("%4t |  %b  |      %b       |        %b       | Only X3 requests", $time, rst, req, grant);

        // Test 2: Simultaneous requests on X3 and X1 -> X1 must win
        req = 4'b1010; #10;
        $display("%4t |  %b  |      %b       |        %b       | X3, X1 active -> G1 granted", $time, rst, req, grant);

        // Test 3: Simultaneous requests on all inputs -> X0 must win
        req = 4'b1111; #10;
        $display("%4t |  %b  |      %b       |        %b       | All active -> G0 granted", $time, rst, req, grant);

        // Test 4: Simultaneous requests on X2 and X3 -> X2 must win
        req = 4'b1100; #10;
        $display("%4t |  %b  |      %b       |        %b       | X3, X2 active -> G2 granted", $time, rst, req, grant);

        // Test 5: No request
        req = 4'b0000; #10;
        $display("%4t |  %b  |      %b       |        %b       | None active -> No grant", $time, rst, req, grant);

        // Test 6: Reset during active request
        req = 4'b1111;
        #3 rst = 1; #7;
        $display("%4t |  %b  |      %b       |        %b       | Reset asserted -> Cleared", $time, rst, req, grant);

        $display("----------------------------------------------------------------");
        $finish;
    end
endmodule