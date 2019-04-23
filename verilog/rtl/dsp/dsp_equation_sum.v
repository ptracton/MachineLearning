//                              -*- Mode: Verilog -*-
// Filename        : dsp_equation_sum.v
// Description     : DSP Equation Sum
// Author          : Phil Tracton
// Created On      : Tue Apr 23 17:04:29 2019
// Last Modified By: Phil Tracton
// Last Modified On: Tue Apr 23 17:04:29 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!
module dsp_equation_sum (/*AUTOARG*/
   // Outputs
   dsp_output0_reg, dsp_output1_reg, dsp_output2_reg, dsp_output3_reg,
   dsp_output4_reg,
   // Inputs
   wb_clk, wb_rst, dsp_input0_reg, dsp_input1_reg, dsp_input2_reg,
   dsp_input3_reg, dsp_input4_reg
   ) ;

   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;
   output reg interrupt;
   output reg error;

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

endmodule // dsp_equation_sum
