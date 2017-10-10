`timescale 1ns / 100ps
`default_nettype none

module top();

    wire [31:0] cor_pc;
    wire [31:0] nxt_pc;

    wire [31:0] inst;
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

    wire [31:0] regsin [0:31];
    wire [31:0] regsout [0:31];
    wire [31:0] regenable;

    wire [31:0] eximmd;
    wire [31:0] rd_data;
    wire [31:0] rs_data;
    wire [31:0] rt_data;
    wire [31:0] alu_data;
    wire immflag;

    register pc(.inp(nxt_pc), .clk(clk), .enable(), .outp(cor_pc));
    register lr(.inp(cor_pc), .clk(clk), .enable(), .outp());

    inst_decoder inst_decoder(.inst(inst), .opecode(opecode), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .funct(funct), .immd(immd), .addr(addr));

    reg_writer reg_writer(.r_gfflag(out_gof), .r_num(rd), .r_data(rd_data), .enable(), .regsin(regsin), .enables(regenable), .clk(clk));
    registers regs(.inreg(regsin), .enable(regenable), .clk(clk), .outreg(regsout));
    reg_reader reg_reader1(.r_gfflag(in_gof), .r_num(rs), .r_data(rs_data), .regsout(regsout), .clk(clk));
    reg_reader reg_reader2(.r_gfflag(in_gof), .r_num(rt), .r_data(rt_data), .regsout(regsout), .clk(clk));

    immd_extender(.immd(immd), .zors(), .eximmd(eximmd));
    data_selector data_selector1(.data0(rt_data), .data1(eximmd), .choice(), .odata(alu_data));
    alu alu(.rs(rs_data), .rt(), .funct(alu_funct), .shamt(shamt), .rd());

    pc_incrementer pc_incrementer(.cpc(), .npc());

endmodule

`default_nettype wire
