`timescale 1ns/1ps;
module clk_gate_tb();
reg clk,d,en;
wire q;
clk_gate dut (.d(d),.clk(clk),.en(en),.q(q));
initial begin
clk=0;
end
always  #5 clk=~clk ;
int i,j;
initial begin
en = 1'b1;
d= 1'b1;

for (i=0;i<10;i=i+1)begin
d=~d;
#12;
end
en = 1'b0;
for (j=0;j<10;j=j+1)begin
d=~d;
#12;
end
$finish;
end
endmodule