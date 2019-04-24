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
   dsp_output4_reg, done, file_num, file_write, file_read,
   file_write_data,
   // Inputs
   wb_clk, wb_rst, rd_ptr, wr_ptr, dsp_input0_reg, dsp_input1_reg,
   dsp_input2_reg, dsp_input3_reg, dsp_input4_reg, file_read_data,
   file_active
   ) ;

   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;
   input [31:0] rd_ptr;
   input [31:0] wr_ptr;

   input [dw-1:0] dsp_input0_reg;
   input [dw-1:0] dsp_input1_reg;
   input [dw-1:0] dsp_input2_reg;
   input [dw-1:0] dsp_input3_reg;
   input [dw-1:0] dsp_input4_reg;

   output wire [dw-1:0] dsp_output0_reg;
   output wire [dw-1:0] dsp_output1_reg;
   output wire [dw-1:0] dsp_output2_reg;
   output wire [dw-1:0] dsp_output3_reg;
   output wire [dw-1:0] dsp_output4_reg;
   output wire          done;

   output wire [7:0] file_num;
   output wire       file_write;
   output wire       file_read;
   output wire [31:0] file_write_data;
   input [31:0]      file_read_data;
   input             file_active;


   dsp_equation_sum
     sum(
         // Outputs
         .interrupt(interrupt),
         .error(error),
         .file_num(file_num),
         .file_write(file_write),
         .file_read(file_read),
         .file_write_data(file_write_data),
         .equation_done(done),
         .dsp_output0_reg(dsp_output0_reg),

         // Inputs
         .wb_clk(wb_clk),
         .wb_rst(wb_rst),
         .rd_ptr(rd_ptr),
         .wr_ptr(wr_ptr),
         .dsp_input0_reg(dsp_input0_reg),
         .dsp_input1_reg(dsp_input1_reg),
         .dsp_input3_reg(dsp_input3_reg),
         .file_read_data(file_read_data),
         .file_active(file_active)
         ) ;

endmodule // dsp_equations_top
