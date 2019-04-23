//                              -*- Mode: Verilog -*-
// Filename        : dsp_equations_top.v
// Description     : DSP Equations Top
// Author          : Phil Tracton
// Created On      : Tue Apr 23 16:39:41 2019
// Last Modified By: Phil Tracton
// Last Modified On: Tue Apr 23 16:39:41 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!
`include "dsp_includes.vh"

module dsp_equations_top (/*AUTOARG*/
   // Outputs
   dsp_output0_reg, dsp_output1_reg, dsp_output2_reg, dsp_output3_reg,
   dsp_output4_reg, start, file_num, file_write, file_read,
   file_write_data,
   // Inputs
   wb_clk, wb_rst, dsp_input0_reg, dsp_input1_reg, dsp_input2_reg,
   dsp_input3_reg, dsp_input4_reg, file_read_data
   ) ;

   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;

   input [dw-1:0] dsp_input0_reg;
   input [dw-1:0] dsp_input1_reg;
   input [dw-1:0] dsp_input2_reg;
   input [dw-1:0] dsp_input3_reg;
   input [dw-1:0] dsp_input4_reg;

   output reg [dw-1:0] dsp_output0_reg;
   output reg [dw-1:0] dsp_output1_reg;
   output reg [dw-1:0] dsp_output2_reg;
   output reg [dw-1:0] dsp_output3_reg;
   output reg [dw-1:0] dsp_output4_reg;

   output reg       start;

   output reg [7:0] file_num;
   output reg       file_write;
   output reg       file_read;
   output reg [31:0] file_write_data;
   input [31:0]      file_read_data;


   dsp_equation_sum
     sum(
         // Outputs
         .dsp_output0_reg(),
         .dsp_output1_reg(),
         .dsp_output2_reg(),
         .dsp_output3_reg(),
         .dsp_output4_reg(),
         // Inputs
         .wb_clk(wb_clk),
         .wb_rst(wb_rst),
         .dsp_input0_reg(),
         .dsp_input1_reg(),
         .dsp_input2_reg(),
         .dsp_input3_reg(),
         .dsp_input4_reg()
         ) ;

endmodule // dsp_equations_top
