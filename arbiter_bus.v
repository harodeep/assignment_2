module priority_arbiter (
    input  wire       clk,
    input  wire       rst,      // synchronous, active-high
    input  wire       x0, x1, x2, x3,
    output reg  [3:0] grant     // one-hot: grant[0] = X0 ... grant[3] = X3
);

    // Combinational priority logic (6 gates)
    wire g0 = x0;
    wire g1 = ~x0 & x1;
    wire g2 = ~x0 & ~x1 & x2;
    wire g3 = ~x0 & ~x1 & ~x2 & x3;

    // Registered grant: stable until next clock edge or reset
    always @(posedge clk) begin
        if (rst)
            grant <= 4'b0000;
        else
            grant <= {g3, g2, g1, g0};
    end

endmodule