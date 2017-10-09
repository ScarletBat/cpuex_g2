`timescale 1ns / 100ps
`default_nettype none

module pc_incrementer(
    input [31:0] cpc,
    output [31:0] npc);

    assign npc = cpc + 4;

endmodule 

`default_nettype wire
