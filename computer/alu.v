`timescale 1ns / 100ps
`default_nettype none

module alu(
   input wire [31:0] rs,
   input wire [31:0] rt,
   input wire [5:0] funct,
   input wire [4:0] shamt,
   output wire [31:0] rd);

   localparam funct_add = 6'b100000;
   localparam funct_sub = 6'b100010;
   localparam funct_and = 6'b100100;
   localparam funct_or  = 6'b100101;
   localparam funct_xor = 6'b100110; 
   localparam funct_nor = 6'b100111;
   localparam funct_sll = 6'b000000; 
   localparam funct_srl = 6'b000010; 
   localparam funct_sra = 6'b000011;

   assign rd = funct == funct_add ? rs + rt :
      funct == funct_sub ? rs - rt :
      funct == funct_and ? rs & rt :
      funct == funct_or  ? rs | rt :
      funct == funct_xor ? rs ^ rt :
      funct == funct_nor ? ~(rs | rt) :
      funct == funct_sll ? rs << shamt :
      funct == funct_srl ? rs >> shamt :
      funct == funct_sra ? {{{32{rs[31]}}, rs} >> shamt}[31:0] : 32'b0;

endmodule
`default_nettype wire
