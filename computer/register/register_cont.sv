`timescale 1ns / 100ps
`default_nettype none

module register (
   input reg [31:0] inp,
   output reg [31:0] outp,
   input wire clk,
   input wire gf_flag, // 0:general 1:float
   input wire rwflag, // 0:read 1:write
   input wire [3:0] regnum,
   input wire enable) // 0:disable 1:enable

   reg [31:0] gen_reg [0:15];
   reg [31:0] flt_reg [0:15];

   always @(posedge clk) begin
      if (enable) begin
         if(rwflag) begin
            if(gf_flag) begin
               flt_reg[regnum] <= inp;
            end else begin
               gen_reg[regnum] <= inp;
            end
         end else begin
            if(gf_flag) begin
               outp <= flt_reg[regnum];
            end else begin
               outp <= gen_reg[regnum];
            end
         end
      end
   end

endmodule
