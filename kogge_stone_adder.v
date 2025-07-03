`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institute: Vivekananda institute Of Professional Studies Technical campus [VISP-TC]
// Engineer: Electronic Engineering VLSI & DT
// 
// Create Date: 07/01/2025 07:46:44 PM
// Module Name: kogge_stone_adder
// Project Name: kogge Stone Adder
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//////////////////////////////////////////////////////////////////////////////////

module kogge_stone_adder(
input [31:0] A, 
input [31:0] B,
input Cin, //carry in
output [31:0] sum, //sum output
output Cout //carryout
);
//Generate & Propogate signals
wire [31:0] G; //Generate signals
wire [31:0] P; //propogate signals
wire [31:0] C; //carry signals
genvar i;
//Pre-Processing Stage
//compute initial Generate & propogate
generate
for(i=0;i<32;i=i+1)
begin: precompute
assign G[i]=A[i]&B[i]; //will always generate carry if both bits are 1
assign P[i]=A[i]^B[i]; //will pass the carry if one bit is 1
end
endgenerate
//wires for stages
wire [31:0] G1,P1;
wire [31:0] G2,P2;
wire [31:0] G3,P3;
wire [31:0] G4,P4;
wire [31:0] G5,P5;
//Parallel Prefix Tree [5 stages combining G/P pairs]
//stage-1
generate
for(i=0;i<32;i=i+1)
begin: stage1
if(i==0)begin 
assign G1[i]=G[i]; 
assign P1[i]=P[i]; 
end
else begin
assign G1[i]=G[i]|(P[i]&G[i-1]);
assign P1[i]=P[i]&P[i-1];
end
end
endgenerate
//stage-2
generate
for(i=0;i<32;i=i+1)
begin: stage2
if(i<2)begin 
assign G2[i]=G1[i]; 
assign P2[i]=P1[i]; 
end
else begin
assign G2[i]=G1[i]|(P1[i]&G1[i-2]);
assign P2[i]=P1[i]&P1[i-2];
end
end
endgenerate
//stage-3 //4-bits combine
generate
for(i=0;i<32;i=i+1)
begin: stage3
if(i<4)begin 
assign G3[i]=G2[i]; 
assign P3[i]=P2[i]; 
end
else begin
assign G3[i]=G2[i]|(P2[i]&G2[i-4]);
assign P3[i]=P2[i]&P2[i-4];
end
end
endgenerate
//stage4 //8-bits combine
generate
for(i=0;i<32;i=i+1)
begin: stage4
if(i<8)begin 
assign G4[i]=G3[i]; 
assign P4[i]=P3[i]; 
end
else begin
assign G4[i]=G3[i]|(P3[i]&G3[i-8]);
assign P4[i]=P3[i]&P3[i-8];
end
end
endgenerate
generate
for(i=0;i<32;i=i+1)
begin: stage5
if(i<16)begin 
assign G5[i]=G4[i]; 
assign P5[i]=P4[i]; 
end
else begin
assign G5[i]=G4[i]|(P4[i]&G4[i-16]);
assign P5[i]=P4[i]&P4[i-16];
end
end
endgenerate
//compute carries for each bit 
assign C[0] = Cin;
generate
for(i=1;i<32;i=i+1) begin : carry_compute
    assign C[i] = G5[i-1] | (P5[i-1] & Cin);
end
endgenerate

//compute sum
generate
for(i=0;i<32;i=i+1)
begin
assign sum[i]=P[i]^C[i];
end
endgenerate
//final carry out 
assign Cout=G5[31]|(P5[31]&Cin);
endmodule