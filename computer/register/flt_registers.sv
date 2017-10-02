`timescale 1ns / 1000ps
`default_nettype none

module flt_registers(
   input wire [31:0] inreg [0:15],
   input wire enable [0:15],
   input wire clk,
   output wire [31:0] outreg [0:15]);

   // f0 - f15 : float registers
   genvar i;
   for (i=0; i<16; i=i+1) begin
      register i_r(.inp(inreg[i]), .clk(clk), .enable(enable[i]), .outp(outreg[i]));
   end

`default_nettype wire
