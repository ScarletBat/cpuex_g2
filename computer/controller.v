`timescale 1ns / 100ps
`default_nettype none

module controller(
   input wire rstn,
   input wire [5:0] opecode,
   input wire [5:0] funct,
   input wire clk,
   
   output wire [5:0] alu_func,
   output wire in_gof,
   output wire out_gof,
   output wire zors,
   output wire reorim,
   
   output wire write_reg,
   output wire write_pc,
   output wire write_lr,

   output wire [1:0] cp_type,
   output wire jrorrt,
   output wire enbranch,
   input wire zflag);

   reg [1:0] status = 2'b00;

   reg write_reg_r = 1'b0;
   reg write_pc_r = 1'b0;
   reg write_lr_r = 1'b0;

   assign in_gof = 1'b0;
   assign out_gof = 1'b0;
   
   assign zors = 1'b0;
   assign enbranch = zflag^opecode[0];

   assign write_reg = write_reg_r;
   assign write_pc = write_pc_r;
   assign write_lr = write_lr_r;

   assign reorim = (opecode == 6'b001000) || (opecode == 6'b001100) || (opecode == 6'b001101) || (opecode == 6'b001010) || (opecode == 6'b000100) || (opecode == 6'b000101);

   assign alu_func = opecode == 6'b0 ? funct :
      opecode == 6'b001000 ? 6'b100000 :
      opecode == 6'b001100 ? 6'b100100 :
      opecode == 6'b001101 ? 6'b100101 :
      opecode == 6'b001010 ? 6'b101010 :
      opecode == 6'b000100 ? 6'b100010 :
      opecode == 6'b000101 ? 6'b100010 : 6'b000000;

   assign cp_type = opecode == 6'b111111 ? 2'b01 :
      (opecode == 6'b000000) && (funct == 6'b001000) ? 2'b01 :
      opecode == 6'b000010 ? 2'b10 :
      opecode == 6'b000011 ? 2'b10 :
      opecode == 6'b000100 ? 2'b11 :
      opecode == 6'b000101 ? 2'b11 : 2'b00;

   always @(posedge clk) begin
      if(~rstn) begin
         status <= 2'b00;
      end else if (status == 2'b00) begin
         write_pc_r <= 1'b1;
         status <= 2'b01;
      end else begin
         write_pc_r <= 1'b0;
         status <= 2'b00;
      end
   end

endmodule

`default_nettype wire
