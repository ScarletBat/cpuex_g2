`include "common.h"

module top(
   input wire clk,
   input wire rstn,
   input wire [`WIDTH-1:0] instr,

   output wire [`WIDTH-1:0] program_counter,
   output wire [`WIDTH-1:0] link_register,

   output wire [`WIDTH-1:0] mem_addr,
   input wire [`WIDTH-1:0] mem_rdata,
   output wire [`WIDTH-1:0] mem_wdata,
   output wire mem_we,

   input wire [5:0] regnum,
   output wire [`WIDTH-1:0] reggg
   );

    wire [`WIDTH-1:0] cor_pc;
    wire [`WIDTH-1:0] nxt_pc;
    wire [`WIDTH-1:0] lr_data;
    wire [`WIDTH-1:0] regpc;

    wire [5:0] opecode;
    wire [4:0] rd;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] immd;
    wire [25:0] addr;

    wire [5:0] alu_funct;
    wire in_gof;
    wire out_gof;
    wire zors;
    wire reorim;
    wire write_pc;
    wire write_lr;
    wire write_reg;
    wire [1:0] cp_type;
    wire jrorrt;
    wire enbranch;
    wire zflag;
    wire mem_we;
    wire loadornot;
    wire lsorlui;
    wire memornot;

    wire [`WIDTH*`NUM-1:0] regsin;
    wire [`WIDTH*`NUM-1:0] regsout;
    wire [`NUM-1:0] regenable;

    wire [31:0] eximmd;
    wire [31:0] rd_data;
    wire [31:0] tf_data;
    wire [31:0] rs_data;
    wire [31:0] rt_data;
    wire [31:0] alu_data;
    wire [31:0] alu_odata;
    wire immflag;

    assign program_counter = cor_pc;
    assign link_register = lr_data;

    register pc(.inp(nxt_pc), .clk(clk), .enable(write_pc), .outp(cor_pc), .rstn(rstn));
    register lr(.inp(cor_pc), .clk(clk), .enable(write_lr), .outp(lr_data), .rstn(rstn));

    inst_decoder inst_decoder(.instrm(instr), .opecode(opecode), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .funct(funct), .immd(immd), .addr(addr));
    controller controller(.rstn(rstn), .opecode(opecode), .funct(funct), .clk(clk), .alu_func(alu_funct), .in_gof(in_gof), .out_gof(out_gof), .zors(zors), .reorim(reorim),  .write_reg(write_reg), .write_pc(write_pc), .write_lr(write_lr), .cp_type(cp_type), .jrorrt(jrorrt), .enbranch(enbranch), .zflag(zflag), .mem_we(mem_we), .loadornot(loadornot), .lsorlui(lsorlui));

    data_selector data_selector3(.data0(alu_odata), .data1(eximmd), .choice(1'b0), .odata(tf_data));
    data_selector data_selector4(.data0(tf_data), .data1(mem_rdata), .choice(loadornot), .odata(rd_data));
    reg_writer reg_writer(.r_gfflag(out_gof), .r_num(rd), .r_data(rd_data), .enable(write_reg), .regsin(regsin), .enables(regenable));
    registers regs(.inreg(regsin), .enable(regenable), .clk(clk), .outreg(regsout), .rstn(rstn));
    reg_reader reg_reader1(.r_gfflag(in_gof), .r_num(rs), .r_data(rs_data), .regsout(regsout), .clk(clk));
    reg_reader reg_reader2(.r_gfflag(in_gof), .r_num(rt), .r_data(rt_data), .regsout(regsout), .clk(clk));
    reg_reader reg_reader3(.r_gfflag(regnum[5]), .r_num(regnum[4:0]), .r_data(reggg), .regsout(regsout), .clk(clk));

    memdata_gen memdata_gen(.immd(immd), .adreg(rs_data), .wdreg(rt_data), .lsorlui(lsorlui), .mem_addr(mem_addr), .mem_wdata(mem_wdata)); 

    immd_extender immd_extender(.immd(immd), .zors(zors), .eximmd(eximmd));
    data_selector data_selector1(.data0(rt_data), .data1(eximmd), .choice(reorim), .odata(alu_data));
    alu alu(.rs(rs_data), .rt(alu_data), .funct(alu_funct), .shamt(shamt), .rd(alu_odata), .zflag(zflag));

    data_selector data_selector2(.data0(rs_data), .data1(lr_data), .choice(jrorrt), .odata(regpc));
    pc_incrementer pc_incrementer(.cpc(cor_pc), .regs(regpc), .immd(immd), .addr(addr), .enbranch(enbranch), .cp_type(cp_type), .npc(nxt_pc));

endmodule

`default_nettype wire
