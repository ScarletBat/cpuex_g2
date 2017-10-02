`timescale 1ns / 1000ps
`default_nettype none

module registers(
   input wire [31:0] inreg [0:31],
   input wire [31:0] enable,
   input wire clk,
   output wire [31:0] outreg [0:31]);

   // r0 : zero register
   assign outreg[0] = {32'b0}

   // r1 - r15 : general registers
   // f0 - f15 (r16 - r31) : float registers
   genvar i;
   for (i=1; i<31; i=i+1) begin
      register i_r(.inp(inreg[i]), .clk(clk), .enable(enable[i]), .outp(outreg[i]));
   end

`default_nettype wire
