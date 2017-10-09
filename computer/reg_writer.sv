`timescale 1ns / 100ps
`default_nettype none

module reg_writer (
   input wire r_gfflag, // 0:general 1:float
   input wire [3:0] r_num,
   input wire [31:0] r_data,
   input wire enable, // 0:disable 1:enable

   output wire [31:0] regsin [0:31],
   output wire [31:0] enables);


   wire [4:0] rnum = {r_gfflag, r_num};

   wire [31:0] enables = {31'b0, 1'b1} << rnum;

   assign regsin[rednum] = r_data;

endmodule

`default_nettype wire
