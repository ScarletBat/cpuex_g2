`include "common.h"

module reg_reader (
   input wire r_gfflag, // 0:general 1:float
   input wire [4:0] r_num,
   output wire [`WIDTH-1:0] r_data,

   input wire [`WIDTH*`NUM-1:0] regsout,
   input wire clk);

   wire [`WIDTH:0] regs_sub [`NUM:0];
   wire [`WIDTH-1:0] reg32 [31:0];
   wire [`WIDTH-1:0] reg16 [15:0];
   wire [`WIDTH-1:0] reg8 [7:0];
   wire [`WIDTH-1:0] reg4 [3:0];
   wire [`WIDTH-1:0] reg2 [1:0];

   wire [5:0] a = {r_gfflag, r_num};

   generate
    genvar i;
    for (i=0; i<`NUM; i=i+1) begin
      assign regs_sub[i] = regsout[i*`WIDTH+`WIDTH-1:i*`WIDTH];
    end
    for (i=0; i<32; i=i+1) begin
      assign reg32[i] = r_gfflag == 1'b1 ? regs_sub[i+32] : regs_sub[i];
    end
    for (i=0; i<16; i=i+1) begin
      assign reg16[i] = r_num[4] == 1'b1 ? reg32[i+16] : reg32[i];
    end
    for (i=0; i<8; i=i+1) begin
      assign reg8[i] = r_num[3] == 1'b1 ? reg16[i+8] : reg16[i];
    end
    for (i=0; i<4; i=i+1) begin
      assign reg4[i] = r_num[2] == 1'b1 ? reg8[i+4] : reg8[i];
    end
    for (i=0; i<2; i=i+1) begin
      assign reg2[i] = r_num[1] == 1'b1 ? reg4[i+2] : reg4[i];
    end
endgenerate
   assign r_data = r_num[0] == 1'b1 ? reg2[1] : reg2[0];
   
endmodule

`default_nettype wire
