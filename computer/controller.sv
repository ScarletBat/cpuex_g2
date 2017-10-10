`timescale 1ns / 100ps
`default_nettype none

module controller(
   input wire [5:0] opecode,
   input wire [5:0] funct,
   
   output wire [5:0] alu_func,
   output wire in_gof,
   output wire out_gof);

   assign in_gof = 1'b0;
   assign out_gof = 1'b0;

   assign alu_func = inst[31:26] == 6'b0 ? funct :
      inst[31:26] == 6'b001000 ? 6'b100000 :
      inst[31:26] == 6'b001100 ? 6'b100100 :
      inst[31:26] == 6'b001101 ? 6'b100101 :
      inst[31:26] == 6'b001010 ? 6'b101010 :
      inst[31:26] == 6'b000100 ? 6'b100000 :
      inst[31:25] == 6'b000101 ? 6'b100000 ; 6'b000000;

   assign opetype = inst[31:26] == 6'b0 ? 2'b00 :
      inst[31:26] == 6'b000010 ? 2'b10 : 2'b01;

`default_nettype wire
