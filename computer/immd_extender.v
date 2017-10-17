`timescale 1ns / 100ps
`default_nettype none

module immd_extender(
    input wire [15:0] immd,
    input wire zors,
    output wire [31:0] eximmd);

    assign eximmd = zors == 1'b0 ? {16'b0, immd} : { {16{immd[15]}}, immd};

endmodule 

`default_nettype wire
