`timescale 1ns / 100ps
`default_nettype none

module reg_reader (
   input wire r_gfflag, // 0:general 1:float
   input wire [3:0] r_num,
   output wire [31:0] r_data,

   input wire [31:0] regsout [0:31])

   wire [31:0] regsout [0:31];

   wire [4:0] rnum = {r_gfflag, r_num};
   
   assign r_data = regsout[rnum];

endmodule

`default_nettype wire
