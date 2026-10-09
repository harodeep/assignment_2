`timescale 1ns/1ps;
module swap_reg(din,clk,freeze,swap,A,B);
input clk,freeze,swap;
input [7:0] din;
output reg [7:0] A,B;
always@(posedge clk)begin
 if (freeze==1'b1 && swap==1'b0)begin
 A<=A;
 B<=B;
 end
 else if(swap==1'b1 && freeze==1'b0)begin
 A<=B;
 B<=A;
 end
 else begin
 A<=din;
 B<=A;
 end
 end
 endmodule