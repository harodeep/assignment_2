`timescale 1ns/1ps
module clk_gate(d,q,clk,en);
input d,clk,en;
output reg q;
reg clk1;
always@(*)begin
clk1=clk & en;
end
always@(posedge clk1) begin
q<=d;
end
endmodule