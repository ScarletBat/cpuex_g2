`timescale 1ns / 1000ps
`default_nettype none

module register(
   input wire [31:0] inp,
   input wire clk,
   input wire enable,
   output wire [31:0] outp);

   reg [31:0] data;
   assign outp = data;

   always @(posedge clk) begin
      data <= inp;
   end
endmodule

`default_nettype wire
