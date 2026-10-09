`timescale 1ns/1ps

module dual_reg_swap (
    input  wire       clk,
    input  wire       rst_n,     // Active-low asynchronous reset
    input  wire       freeze,    // Priority 1: Hold both registers
    input  wire       swap,      // Priority 2: Exchange values
    input  wire [7:0] din,       // Input data to load into A
    output reg  [7:0] A,         // Register A
    output reg  [7:0] B          // Register B
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A <= 8'h00;
            B <= 8'h00;
        end else if (freeze) begin
            // Hold current values
            A <= A;
            B <= B;
        end else if (swap) begin
            // Simultaneous exchange in a single cycle
            A <= B;
            B <= A;
        end else begin
            // Normal operation: A loads din, B gets previous A
            A <= din;
            B <= A;
        end
    end

endmodule