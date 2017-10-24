`timescale 1ns / 100ps
`default_nettype none

module inst_decoder(
   input wire [31:0] instrm,
   output wire [5:0] opecode,
   output wire [4:0] rd,
   output wire [4:0] rs,
   output wire [4:0] rt,
   output wire [4:0] shamt,
   output wire [5:0] funct,
   output wire [15:0] immd,
   output wire [25:0] addr);

   assign opecode = instrm[31:26];

   assign rd = instrm[25:21];
   assign rs = (instrm[31:26] == 6'b001111) ? instrm[25:21] : instrm[20:16];
   assign rt = ((instrm[31:26] == 6'b000100) || (instrm[31:26] == 6'b000101) || (instrm[31:26] == 6'b101011)) ? instrm[25:21] : instrm[15:11];

   assign shamt = instrm[10:6];
   assign funct = instrm[5:0];

   assign immd = instrm[15:0];
   assign addr = instrm[25:0];
   
endmodule

`default_nettype wire
