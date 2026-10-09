`timescale 1ns/1ps

module clock_gater (
    input  wire clk,         // Source clock
    input  wire en,          // Enable control signal
    output wire gclk         // Gated clock output
);

    reg en_latched;

    // Negative-level-sensitive latch: transparent when clk == 0, latches when clk == 1
    always @(clk or en) begin
        if (!clk) begin
            en_latched <= en;
        end
    end

    // Gated clock generation
    assign gclk = clk & en_latched;

endmodule