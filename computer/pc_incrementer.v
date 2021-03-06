`timescale 1ns / 100ps
`default_nettype none

module pc_incrementer(
    input wire [31:0] cpc,
    input wire [31:0] regs,
    input wire [15:0] immd,
    input wire [25:0] addr,
    input wire enbranch,
    
    input wire [1:0] cp_type,
    
    output wire [31:0] npc);
    
    wire [31:0] a = 32'd4 + {{14{immd[15]}}, immd, 2'b0};

   // np_type : 00->default 01->jr,ret 10->j,jal 11->beq,bne 

    assign npc = cp_type == 2'b00 ? cpc + 32'd4 :
    	cp_type == 2'b01 ? regs :
    	cp_type == 2'b10 ? {cpc[31:28], addr, 2'b0} : 
      enbranch == 1'b1 ? cpc + a : cpc + 32'd4;
endmodule 

`default_nettype wire
