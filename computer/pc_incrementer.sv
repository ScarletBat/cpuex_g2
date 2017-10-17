`timescale 1ns / 100ps
`default_nettype none

module pc_incrementer(
    input wire [31:0] cpc,
    input wire [31:0] reg,
    input wire [15:0] immd,
    input wire [25:0] addr,
    
    imput wire [1:0] cp_type
    
    output wire [31:0] npc);

    assign npc = np_type == 2'b00 ? cpc + 4 :
    	np_type = 2'b01 ? reg '
    	np_tppe _ 2'b10 ? {cpc[31:26] ,addr} : cpc + {16'b0, immd};

endmodule 

`default_nettype wire
