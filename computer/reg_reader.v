`include "common.h"

module reg_reader (
   input wire r_gfflag, // 0:general 1:float
   input wire [4:0] r_num,
   output wire [`WIDTH-1:0] r_data,

   input wire [`WIDTH*`NUM-1:0] regsout,
   input wire clk);

   wire [`WIDTH*32-1:0] reg32 = r_gfflag == 1'b1 ? regsout[`WIDTH*64-1:`WIDTH*32] : regsout[`WIDTH*32-1:0];
   wire [`WIDTH*16-1:0] reg16 = r_num[4] == 1'b1 ? reg32[`WIDTH*32-1:`WIDTH*16] : reg16[`WIDTH*16-1:0];
   wire [`WIDTH*8-1:0] reg8 = r_num[3] == 1'b1 ? reg16[`WIDTH*16-1:`WIDTH*8] : reg16[`WIDTH*8-1:0];
   wire [`WIDTH*4-1:0] reg4 = r_num[2] == 1'b1 ? reg8[`WIDTH*8-1:`WIDTH*4] : reg8[`WIDTH*4-1:0];
   wire [`WIDTH*2-1:0] reg2 = r_num[1] == 1'b1 ? reg4[`WIDTH*4-1:`WIDTH*2] : reg4[`WIDTH*2-1:0];
   
   reg [`WIDTH-1:0] temp;

   assign r_data = temp;
   
   always @(posedge clk) begin
   temp <= r_num[0] == 1'b1 ? reg2[`WIDTH*2-1:`WIDTH] : reg2[`WIDTH-1:0];
   end
   
endmodule

`default_nettype wire
