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
   dsp_output4_reg, done, file_num, file_write, file_read, file_reset,
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
   output wire       file_reset;
   output wire [31:0] file_write_data;
   input [31:0]      file_read_data;
   input             file_active;
   wire              interrupt;
   wire              error;

   wire              interrupt_sum;
   wire              error_sum;
   wire [7:0]        file_num_sum;
   wire              file_write_sum;
   wire              file_read_sum;
   wire [31:0]       file_write_data_sum;
   wire              done_sum;

   wire              interrupt_multiply;
   wire              error_multiply;
   wire [7:0]        file_num_multiply;
   wire              file_write_multiply;
   wire              file_read_multiply;
   wire [31:0]       file_write_data_multiply;
   wire              done_multiply;

   wire              interrupt_dtree;
   wire              error_dtree;
   wire [7:0]        file_num_dtree;
   wire              file_write_dtree;
   wire              file_read_dtree;
   wire [31:0]       file_write_data_dtree;
   wire              done_dtree;
   wire              file_reset_dtree;

   wire  equation_enable_sum = (dsp_input0_reg[`F_DSP_SLAVE_EQUATION_NUMBER] == `B_DSP_EQUATION_SUM);
   wire  equation_enable_multiply = (dsp_input0_reg[`F_DSP_SLAVE_EQUATION_NUMBER] == `B_DSP_EQUATION_MULTIPLY);
   wire  equation_enable_dtree = (dsp_input0_reg[`F_DSP_SLAVE_EQUATION_NUMBER] == `B_DSP_EQUATION_DTREE);

   assign file_reset = (equation_enable_dtree) ? file_reset_dtree : 0;

   assign interrupt = (equation_enable_sum) ? interrupt_sum :
                      (equation_enable_multiply) ? interrupt_multiply :
                      (equation_enable_dtree) ? interrupt_dtree :
                      0;

   assign error = (equation_enable_sum) ? error_sum :
                  (equation_enable_multiply) ? error_multiply:
                  (equation_enable_dtree) ? error_dtree:
                  0;

   assign file_num = (equation_enable_sum) ? file_num_sum :
                     (equation_enable_multiply) ? file_num_multiply:
                     (equation_enable_dtree) ? file_num_dtree:
                     0;

   assign file_write = (equation_enable_sum) ? file_write_sum :
                       (equation_enable_multiply) ? file_write_multiply:
                       (equation_enable_dtree) ? file_write_dtree:
                       0;

   assign file_read = (equation_enable_sum) ? file_read_sum :
                      (equation_enable_multiply) ? file_read_multiply:
                      (equation_enable_dtree) ? file_read_dtree:
                      0;

   assign file_write_data = (equation_enable_sum) ? file_write_data_sum :
                            (equation_enable_multiply) ? file_write_data_multiply:
                            (equation_enable_dtree) ? file_write_data_dtree:
                            0;

   assign done = (equation_enable_sum) ? done_sum :
                 (equation_enable_multiply) ? done_multiply:
                 (equation_enable_dtree) ? done_dtree:
                 0;

   dsp_equation_sum
     sum(
         // Outputs
         .interrupt(interrupt_sum),
         .error(error_sum),
         .file_num(file_num_sum),
         .file_write(file_write_sum),
         .file_read(file_read_sum),
         .file_write_data(file_write_data_sum),
         .equation_done(done_sum),
         .dsp_output0_reg(dsp_output0_reg),

         // Inputs
         .wb_clk(wb_clk),
         .wb_rst(wb_rst),
         .equation_enable(equation_enable_sum),
         .rd_ptr(rd_ptr),
         .wr_ptr(wr_ptr),
         .dsp_input0_reg(dsp_input0_reg),
         .dsp_input1_reg(dsp_input1_reg),
         .dsp_input3_reg(dsp_input3_reg),
         .file_read_data(file_read_data),
         .file_active(file_active)
         ) ;


   dsp_equation_multiply
     multiply (
               // Outputs
               .interrupt(interrupt_multiply),
               .error(error_multiply),
               .file_num(file_num_multiply),
               .file_write(file_write_multiply),
               .file_read(file_read_multiply),
               .file_write_data(file_write_data_multiply),
               .equation_done(done_multiply),
               .dsp_output0_reg(dsp_output0_reg),
               .dsp_output1_reg(dsp_output1_reg),
               // Inputs
               .wb_clk(wb_clk),
               .wb_rst(wb_rst),
               .equation_enable(equation_enable_multiply),
               .dsp_input0_reg(dsp_input0_reg),
               .dsp_input1_reg(dsp_input1_reg),
               .dsp_input2_reg(dsp_input2_reg),
               .dsp_input3_reg(dsp_input3_reg),
               .file_read_data(file_read_data),
               .file_active(file_active),
               .rd_ptr(rd_ptr),
               .wr_ptr(wr_ptr)
               );
   dsp_equation_dtree
     dtree (
               // Outputs
               .interrupt(interrupt_dtree),
               .error(error_dtree),
               .file_num(file_num_dtree),
               .file_write(file_write_dtree),
               .file_read(file_read_dtree),
               .file_reset(file_reset_dtree),
               .file_write_data(file_write_data_dtree),
               .equation_done(done_dtree),
               .dsp_output0_reg(dsp_output0_reg),
               .dsp_output1_reg(dsp_output1_reg),
               // Inputs
               .wb_clk(wb_clk),
               .wb_rst(wb_rst),
               .equation_enable(equation_enable_dtree),
               .dsp_input0_reg(dsp_input0_reg),
               .dsp_input1_reg(dsp_input1_reg),
               .dsp_input2_reg(dsp_input2_reg),
               .dsp_input3_reg(dsp_input3_reg),
               .file_read_data(file_read_data),
               .file_active(file_active),
               .rd_ptr(rd_ptr),
               .wr_ptr(wr_ptr)
               );


endmodule // dsp_equations_top
