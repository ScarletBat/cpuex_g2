`include "common.h"

module reg_writer (
   input wire r_gfflag, // 0:general 1:float
   input wire [4:0] r_num,
   input wire [`WIDTH-1:0] r_data,
   input wire enable, // 0:disable 1:enable

   output wire [`WIDTH*`NUM-1:0] regsin,
   output wire [`NUM:0] enables);


   wire [5:0] rnum = {r_gfflag, r_num};

   assign enables = {{`NUM'b0, 1'b1} << rnum}[`NUM-1:0];

   genvar i;
   for (i=0; i<`WIDTH*`NUM; i=i+`WIDTH) begin
      assign regsin[i+`WIDTH-1 : i] = i == r_num ? r_data : `WIDTH'b0;
   end

endmodule

`default_nettype wire
