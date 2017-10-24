`include "common.h"

module reg_writer (
   input wire r_gfflag, // 0:general 1:float
   input wire [4:0] r_num,
   input wire [`WIDTH-1:0] r_data,
   input wire enable, // 0:disable 1:enable

   output wire [`WIDTH*`NUM-1:0] regsin,
   output wire [`NUM-1:0] enables);

   wire [`WIDTH-1:0] regs_sub [`NUM-1:0];
   wire [5:0] rnum = {r_gfflag, r_num};

   generate
       genvar i;
       for (i=0; i<`NUM; i=i+1) begin
          assign regsin[i*`WIDTH+`WIDTH-1:i*`WIDTH] = regs_sub[i];
       end
       for (i=0; i<`NUM; i=i+1) begin
          assign regs_sub[i] = i == r_num ? r_data : `WIDTH'b0;
          assign enables[i] = i == r_num ? enable : 1'b0;
       end
   endgenerate

endmodule

`default_nettype wire
