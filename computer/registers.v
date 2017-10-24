`include "common.h"

module registers (
   input wire [`WIDTH * `NUM - 1:0] inreg,
   input wire [`NUM - 1:0] enable,
   (* mark_debug = "true" *)input wire clk,
   input wire rstn,

   (* mark_debug = "true" *)output wire [`WIDTH * `NUM - 1:0] outreg);

   wire [`WIDTH-1:0] inreg_sub [`NUM-1:0];
   wire [`WIDTH-1:0] outreg_sub [`NUM-1:0];
   // r0 : zero register
   assign outreg_sub[0] = {`WIDTH'b0};

   // r1 - r31 : general registers
   // f0 - f31 (r32 - r63) : float registers
   generate
       genvar i;
       for (i=0; i<`NUM; i=i+1) begin
          assign inreg_sub[i] = inreg[i*`WIDTH+`WIDTH-1:i*`WIDTH];
          assign outreg[i*`WIDTH+`WIDTH-1:i*`WIDTH] = outreg_sub[i];
       end
       for (i=1; i<`NUM; i=i+1) begin
          register i_r (.inp(inreg_sub[i]), .clk(clk), .enable(enable[i]), .outp(outreg_sub[i]), .rstn(rstn));
       end
   endgenerate
endmodule

`default_nettype wire
