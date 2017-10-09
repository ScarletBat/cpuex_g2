`timescale 1ns / 100ps
`default_nettype none

module data_selector(
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire choice,
    output wire [31:0] odata);

    assign odata = choice == 1'b0 ? data0 : data1;

endmodule

`default_nettype wire
