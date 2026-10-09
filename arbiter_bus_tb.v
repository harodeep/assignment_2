module tb;
    reg clk = 0, rst = 1, x0, x1, x2, x3;
    wire [3:0] grant;

    priority_arbiter dut (clk, rst, x0, x1, x2, x3, grant);

    always #5 clk = ~clk;

    initial begin
        {x0,x1,x2,x3} = 4'b0000;
        #12 rst = 0;
        #10 {x0,x1,x2,x3} = 4'b1111;  // expect grant = 0001
        #10 {x0,x1,x2,x3} = 4'b0111;  // expect grant = 0010
        #10 {x0,x1,x2,x3} = 4'b0011;  // expect grant = 0100
        #10 {x0,x1,x2,x3} = 4'b0001;  // expect grant = 1000
        #10 {x0,x1,x2,x3} = 4'b0000;  // expect grant = 0000
        #10 {x0,x1,x2,x3} = 4'b1010;  // expect grant = 0001
        #10 rst = 1;                   // expect grant = 0000
        #10 $finish;
    end

    initial $monitor("t=%0t rst=%b req=%b%b%b%b grant=%b",
                     $time, rst, x0, x1, x2, x3, grant);
endmodule