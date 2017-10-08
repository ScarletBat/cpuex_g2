`timescale 1ns / 100ps
`default_nettype none

module top();

    wire [31:0] regsin [0:31];
    wire [31:0] regsout [0:31];
    wire [31:0] regenable;

    reg_writer reg_wrer(.r_gfflag(), .r_num(), .r_data(), .enable(), .regsin(regsin), .enables(regenable), .clk(clk));
    registers regs(.inreg(regsin), .enable(regenable), .clk(clk), .outreg(regsout));
    reg_reader reg_rder1(.r_gfflag(), .r_num(), .r_data(), .regsout(regsout), .clk(clk));
    reg_reader reg_rder2(.r_gfflag(), .r_num(), .r_data(), .regsout(regsout), .clk(clk));

endmodule

`default_nettype wire
