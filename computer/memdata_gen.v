`include "common.h"

module memdata_gen(
   input wire [15:0] immd,
   input wire [31:0] adreg,
   input wire [31:0] wdreg,
   input wire lsorlui,

   output wire [31:0] mem_addr,
   output wire [31:0] mem_wdata);

   assign mem_addr = lsorlui == 1'b1 ? adreg : adreg + {16'b0, immd};
   assign mem_wdata = lsorlui == 1'b1 ? {immd, 16'b0} : wdreg;
endmodule

`default_nettype wire
