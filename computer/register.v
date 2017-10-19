`include "common.h"

module register (
   input wire [`WIDTH-1:0] inp,
   input wire clk,
   input wire enable,
   input wire rstn,
   output wire [`WIDTH-1:0] outp);

   reg [`WIDTH-1:0] data = `WIDTH'b0;
   assign outp = data;

   always @(posedge clk) begin
      if (~rstn) begin
         data <= `WIDTH'b0;
      end else if (enable) begin
         data <= inp;
      end
   end
endmodule

`default_nettype wire
