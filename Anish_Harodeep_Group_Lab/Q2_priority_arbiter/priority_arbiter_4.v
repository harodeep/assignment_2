`timescale 1ns/1ps

module priority_arbiter_4 (
    input  wire       clk,
    input  wire       rst,       // Synchronous/Asynchronous active-high reset
    input  wire [3:0] req,       // req[0]=X0 (highest), req[3]=X3 (lowest)
    output reg  [3:0] grant      // grant[0]=G0 ... grant[3]=G3
);

    wire [3:0] grant_comb;

    // Fixed-priority daisy chain logic (single-cycle resolution)
    assign grant_comb[0] = req[0];
    assign grant_comb[1] = req[1] & ~req[0];
    assign grant_comb[2] = req[2] & ~req[1] & ~req[0];
    assign grant_comb[3] = req[3] & ~req[2] & ~req[1] & ~req[0];

    // Registered grant output to ensure stability across the clock cycle
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            grant <= 4'b0000;
        end else begin
            grant <= grant_comb;
        end
    end

endmodule