//                              -*- Mode: Verilog -*-
// Filename        : syscon.v
// Description     : System Clock and Reset Controller
// Author          : Philip Tracton
// Created On      : Fri Nov 27 13:42:16 2015
// Last Modified By: Philip Tracton
// Last Modified On: Fri Nov 27 13:42:16 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ns/1ns
module syscon (/*AUTOARG*/
   // Outputs
   wb_clk_o, wb_rst_o,
   // Inputs
   clk_pad_i, rst_pad_i
   ) ;
   input clk_pad_i;
   input rst_pad_i;
   output wb_clk_o;
   output wb_rst_o;


   wire   locked;

`ifdef SIM
   assign wb_clk_o = clk_pad_i;
   assign locked = 1'b1;

`else
   // Put technology specific clocking here, things like Xilinx DCM, etc...
`endif

   //
   // Reset generation for wishbone
   //
   // This will keep reset asserted until we get 16 clocks
   // of the PLL/Clock Tile being locked
   //
   reg [31:0] wb_rst_shr;

   always @(posedge wb_clk_o or posedge rst_pad_i)
	 if (rst_pad_i)
	   wb_rst_shr <= 32'hffff_ffff;
	 else
	   wb_rst_shr <= {wb_rst_shr[30:0], ~(locked)};

   assign wb_rst_o = wb_rst_shr[31];

endmodule // syscon
