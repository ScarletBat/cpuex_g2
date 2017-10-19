`timescale 1ns / 100ps
`default_nettype none

module inst_decoder(
   input wire [31:0] inst,
   output wire [5:0] opecode,
   output wire [4:0] rd,
   output wire [4:0] rs,
   output wire [4:0] rt,
   output wire [4:0] shamt,
   output wire [5:0] funct,
   output wire [15:0] immd,
   output wire [25:0] addr);

   assign opecode = inst[31:26];

   assign rd = inst[25:21];
   assign rs = inst[20:16];
   assign rt = inst[15:11];

   assign shamt = inst[10:6];
   assign funct = inst[5:0];

   assign immd = inst[15:0];
   assign addr = inst[25:0];
   
endmodule

`default_nettype wire