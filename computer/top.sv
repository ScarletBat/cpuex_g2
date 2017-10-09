`timescale 1ns / 100ps
`default_nettype none

module top();

    wire [31:0] inst;
    wire [5:0] opecode;
    wire [4:0] rd;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] immd;
    wire [25:0] addr;
    wire [1:0] opetype;

    wire [31:0] regsin [0:31];
    wire [31:0] regsout [0:31];
    wire [31:0] regenable;

    wire [31:0] eximmd;
    wire [31:0] rd_data;
    wire [31:0] rs_data;
    wire [31:0] rt_data;
    wire [31:0] alu_data;
    wire immflag;

    inst_decoder inst_decoder(.inst(inst), .opecode(opecode), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .funct(funct), .immd(immd), .addr(addr), .opetype(opetype));

reg_writer reg_writer(.r_gfflag(), .r_num(rd), .r_data(rd_data), .enable(), .regsin(regsin), .enables(regenable));
    registers regs(.inreg(regsin), .enable(regenable), .clk(clk), .outreg(regsout));
    reg_reader reg_reader1(.r_gfflag(), .r_num(rs), .r_data(rs_data), .regsout(regsout));
    reg_reader reg_reader2(.r_gfflag(), .r_num(rt), .r_data(rt_data), .regsout(regsout));

    immd_extender(.immd(immd), .zors(), .eximmd(eximmd));
    data_selector data_selector1(.data0(rt_data), .data1(eximmd), .choice(), .odata(alu_data));
    alu alu(.rs(rs_data), .rt(), .funct(funct), .shamt(shamt), .rd());

    pc_incrementer pc_incrementer(.cpc(), .npc());

endmodule

`default_nettype wire
