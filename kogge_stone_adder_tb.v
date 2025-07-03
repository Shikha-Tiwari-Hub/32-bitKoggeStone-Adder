`timescale 1ns / 1ps
module kogge_stone_adder_tb;
reg[31:0] A,B;
reg Cin;
wire [31:0] sum;
wire Cout;
kogge_stone_adder uut(
.A(A),
.B(B),
.Cin(Cin),
.sum(sum),
.Cout(Cout)
);
initial begin
$monitor("Time=%0d A=%h B=%h Cin=%b|sum=%h Cout=%b",$time,A,B,Cin,sum,Cout);
//test in different parameters
A=1; B=1; Cin=0; #10;
A=32'hffffffff; B=1; Cin=0; #10;
A=32'h12345678; B=32'h87654321; Cin=0; #10;
A=32'hAAAAAAAA; B=32'h55555555; Cin=1; #10
$finish;
end
endmodule