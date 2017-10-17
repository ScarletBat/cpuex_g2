`include "common.h"

module registers (
   input wire [`WIDTH * `NUM - 1:0] inreg,
   input wire [`NUM - 1:0] enable,
   input wire clk,
   output wire [`WIDTH * `NUM - 1:0] outreg);

   // r0 : zero register
   assign outreg[`WIDTH-1:0] = {`WIDTH'b0};

   // r1 - r31 : general registers
   // f0 - f31 (r32 - r63) : float registers
   genvar i;
   for (i=`WIDTH; i<`NUM*`WIDTH; i=i+`WIDTH) begin
      register i_r (.inp(inreg[i+`WIDTH-1:i]), .clk(clk), .enable(enable[i]), .outp(outreg[i+`WIDTH-1:i]));
   end
endmodule

`default_nettype wire
