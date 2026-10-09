`timescale 1ns/1ps

module barrel_shifter_4bit (
    input  wire [3:0] din,       // 4-bit data input
    input  wire [1:0] amt,       // Shift/rotation amount (0 to 3)
    input  wire [1:0] mode,      // 00: SHL, 01: SHR, 10: ROL, 11: ROR
    output reg  [3:0] dout       // 4-bit shifted output
);

    always @(*) begin
        case (mode)
            2'b00: begin // Logical Left Shift (SHL)
                case (amt)
                    2'b00: dout = din;
                    2'b01: dout = {din[2:0], 1'b0};
                    2'b10: dout = {din[1:0], 2'b00};
                    2'b11: dout = {din[0],   3'b000};
                endcase
            end

            2'b01: begin // Logical Right Shift (SHR)
                case (amt)
                    2'b00: dout = din;
                    2'b01: dout = {1'b0,   din[3:1]};
                    2'b10: dout = {2'b00,  din[3:2]};
                    2'b11: dout = {3'b000, din[3]};
                endcase
            end

            2'b10: begin // Rotate Left (ROL)
                case (amt)
                    2'b00: dout = din;
                    2'b01: dout = {din[2:0], din[3]};
                    2'b10: dout = {din[1:0], din[3:2]};
                    2'b11: dout = {din[0],   din[3:1]};
                endcase
            end

            2'b11: begin // Rotate Right (ROR)
                case (amt)
                    2'b00: dout = din;
                    2'b01: dout = {din[0],   din[3:1]};
                    2'b10: dout = {din[1:0], din[3:2]};
                    2'b11: dout = {din[2:0], din[3]};
                endcase
            end

            default: dout = 4'b0000;
        endcase
    end

endmodule