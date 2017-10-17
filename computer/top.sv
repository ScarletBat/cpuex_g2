`timescale 1ns / 100ps
`default_nettype none

module top(
   input wire clk,
   input wire rstn,
   input wire [31:0] inst,

   input wire [31:0] program_counter;
   );

    wire [31:0] cor_pc;
    wire [31:0] nxt_pc;

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
    wire write_pc;
    wire write_lr;
    wire write_reg;

    wire [31:0] regsin [0:31];
    wire [31:0] regsout [0:31];
    wire [31:0] regenable;

    wire [31:0] eximmd;
    wire [31:0] rd_data;
    wire [31:0] rs_data;
    wire [31:0] rt_data;
    wire [31:0] alu_data;
    wire [31:0] alu_odata;
    wire immflag;

    register pc(.inp(nxt_pc), .clk(clk), .enable(write_pc), .outp(cor_pc));
    register lr(.inp(cor_pc), .clk(clk), .enable(write_lr), .outp());

    inst_decoder inst_decoder(.inst(inst), .opecode(opecode), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .funct(funct), .immd(immd), .addr(addr));
    controller controller(.opecode(opecode), .funct(funct), .clk(clk), .alu_funct(alu_funct), .in_gof(in_gof), .out_gof(out_gof), .zors(zors), .write_reg(write_reg), .write_pc(write_pc), .write_lr(write_lr));

    reg_writer reg_writer(.r_gfflag(out_gof), .r_num(rd), .r_data(rd_data), .enable(write_reg), .regsin(regsin), .enables(regenable), .clk(clk));
    registers regs(.inreg(regsin), .enable(regenable), .clk(clk), .outreg(regsout));
    reg_reader reg_reader1(.r_gfflag(in_gof), .r_num(rs), .r_data(rs_data), .regsout(regsout));
    reg_reader reg_reader2(.r_gfflag(in_gof), .r_num(rt), .r_data(rt_data), .regsout(regsout));

    immd_extender(.immd(immd), .zors(zors), .eximmd(eximmd));
    data_selector data_selector1(.data0(rt_data), .data1(eximmd), .choice(), .odata(alu_data));
    alu alu(.rs(rs_data), .rt(alu_data), .funct(alu_funct), .shamt(shamt), .rd(alu_odata));

    pc_incrementer pc_incrementer(.cpc(cor_pc), .npc());

endmodule

`default_nettype wire
