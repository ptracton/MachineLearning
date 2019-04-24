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
   interrupt, error, file_num, file_write, file_read, file_write_data,
   // Inputs
   wb_clk, wb_rst, dsp_input0_reg, dsp_input1_reg, dsp_input3_reg,
   file_read_data, file_active
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
   input [dw-1:0] dsp_input3_reg;

   output reg [7:0] file_num;
   output reg     file_write;
   output reg     file_read;
   output reg [31:0] file_write_data;
   input  [31:0] file_read_data;
   input         file_active;



   localparam STATE_IDLE                    = 8'h00;
   localparam STATE_READ_INPUT_FILE         = 8'h01;
   localparam STATE_READ_INPUT_FILE_DONE    = 8'h02;
   localparam STATE_OPERATION               = 8'h03;
   localparam STATE_WRITE_READ_FILE         = 8'h04;
   localparam STATE_WRITE_READ_FILE_DONE    = 8'h05;
   localparam STATE_READ_OUTPUT_FILE        = 8'h06;
   localparam STATE_READ_FILE_OUTPUT_DONE   = 8'h07;
   localparam STATE_WRITE_RESULTS_FILE      = 8'h08;
   localparam STATE_WRITE_RESULTS_FILE_DONE = 8'h09;

   reg [7:0]           state;


   wire  equation_state = dsp_input0_reg[`F_DSP_SLAVE_EQUATION_START];
   wire [1:0] data_size =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIZE];
   wire       data_signed =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIGNED] ;

   wire [7:0] input_file = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE0];
   wire [7:0] output_file = dsp_input3_reg[`F_DSP_SLAVE_OUTPUT_FILE0];

   always @(posedge wb_clk)
     if (wb_rst) begin
        state <= STATE_IDLE;
        interrupt <= 0;
        error <= 0;
        file_num <=0;
        file_write <= 0;
        file_read <=0;
        file_write_data <=0;

     end else begin
        case (state)
          STATE_IDLE: begin
             file_num <=0;
             file_write <= 0;
             file_read <=0;
             file_write_data <=0;
             if (equation_state) begin
                state <= STATE_READ_INPUT_FILE;
             end else begin
                state <= STATE_IDLE;
             end
          end
          STATE_READ_INPUT_FILE: begin
             file_read <= 1;
             state <= STATE_READ_INPUT_FILE_DONE;
          end
          STATE_READ_INPUT_FILE_DONE:begin
             if (file_active) begin
                state <= STATE_READ_INPUT_FILE_DONE;
             end else begin
                state <= STATE_IDLE;
             end
          end
          default:begin
             state <= STATE_IDLE;
          end
        endcase // case (state)

     end

endmodule // dsp_equation_sum
