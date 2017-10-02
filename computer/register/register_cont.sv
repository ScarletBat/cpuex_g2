`timescale 1ns / 100ps
`default_nettype none

module reg_cont (
   input wire rd_gfflag, // 0:general 1:float
   input wire [3:0] rd_num,
   input wire [31:0] rd_data,
   input wire enable, // 0:disable 1:enable

   input wire rs_gfflag, // 0:general 1:float
   input wire [3:0] rs_num,
   output wire [31:0] rs_data,

   input wire rt_gfflag, // 0:general 1:float
   input wire [3:0] rt_num,
   output wire [31:0] rt_data,

   output wire [31:0] pc,
   output wire [31:0] pcvalid,
   input wire clk)

   wire [31:0] regsin [0:31];
   wire [31:0] regsout [0:31];

   wire [4:0] rdnum = {rd_gfflag, rd_num};
   wire [4:0] rsnum = {rs_gfflag, rs_num};
   wire [4:0] rtnum = {rt_gfflag, rt_num};

   wire [31:0] enables = {31'b0, 1'b1} << rdnum;

   genvar i;
   for (i=0; i<31; i=i+1) begin
      assign regsin[i] = rdnum==i ? rd_data : {32'b0};

      if rsnum==i begin
         assign rs_data = regsout[i];
      end
      if rtnum==i begin
         assign rt_data = regsout[i];
      end

   end

   registers rgs(.inreg(regsin), .enable(enables), .clk(clk), .outreg(regsout)); 

endmodule

`default_nettype wire
