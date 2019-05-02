//                              -*- Mode: Verilog -*-
// Filename        : dsp_equation_dtree.v
// Description     : DSP Equation Dtree
// Author          : Philip Tracton
// Created On      : Wed Apr 24 18:59:34 2019
// Last Modified By: Philip Tracton
// Last Modified On: Wed Apr 24 18:59:34 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module dsp_equation_dtree (/*AUTOARG*/
   // Outputs
   interrupt, error, file_num, file_write, file_read, file_write_data,
   equation_done, dsp_output0_reg, dsp_output1_reg,
   // Inputs
   wb_clk, wb_rst, equation_enable, dsp_input0_reg, dsp_input1_reg,
   dsp_input2_reg, dsp_input3_reg, file_read_data, file_active,
   rd_ptr, wr_ptr
   ) ;
   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;
   input equation_enable;

   output reg interrupt;
   output reg error;

   input [dw-1:0] dsp_input0_reg;
   input [dw-1:0] dsp_input1_reg;
   input [dw-1:0] dsp_input2_reg;
   input [dw-1:0] dsp_input3_reg;

   output reg [7:0] file_num;
   output reg       file_write;
   output reg       file_read;
   output reg [31:0] file_write_data;
   input [31:0]      file_read_data;
   input             file_active;

   input [31:0]      rd_ptr;
   input [31:0]      wr_ptr;
   output reg        equation_done;
   output reg [31:0] dsp_output0_reg;
   output reg [31:0] dsp_output1_reg;


   wire              equation_start = dsp_input0_reg[`F_DSP_SLAVE_EQUATION_START] & equation_enable;
   wire [1:0]        data_size =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIZE];
   wire              data_signed =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIGNED];

   wire [7:0]        split_file   = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE0];
   wire [7:0]        sensor1_file = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE1];
   wire [7:0]        sensor2_file = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE2];
   wire [7:0]        sensor3_file = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE3];
   wire [7:0]        output_file = dsp_input3_reg[`F_DSP_SLAVE_OUTPUT_FILE0];
   reg [31:0]        dtree_output;
   reg               dtree_result;


   localparam STATE_IDLE                    = 8'h00;
   localparam STATE_READ_SPLIT_FILE0_0      = 8'h01;
   localparam STATE_READ_SPLIT_FILE0_DONE_0 = 8'h02;
   localparam STATE_READ_SPLIT_FILE0_1      = 8'h03;
   localparam STATE_READ_SPLIT_FILE0_DONE_1 = 8'h04;
   localparam STATE_READ_DATA_FILE          = 8'h05;
   localparam STATE_READ_DATA_FILE_DONE     = 8'h06;
   localparam STATE_OPERATION               = 8'h07;
   localparam STATE_WRITE_RESULTS_FILE      = 8'h08;
   localparam STATE_WRITE_RESULTS_FILE_DONE = 8'h09;

   reg [7:0]         state;
   reg [31:0]        sample_count;
   reg [31:0]        file_data_in;
   reg [31:0]        split_value;
   reg [31:0]        split_control;
   reg [31:0]        sensor_data;
   reg [3:0]         dtree_level;

   wire              leaf = split_control[`F_DSP_DTREE_LEAF];
   wire [7:0]        node_output = split_control[`F_DSP_DTREE_OUTPUT];

   wire [7:0] sensor_file = (dtree_level == 4'h1) ? sensor1_file :
              (dtree_level == 4'h2) ? sensor2_file :
              (dtree_level == 4'h3) ? sensor3_file :
              00;


   always @(posedge wb_clk)
     if (wb_rst) begin
        state <= STATE_IDLE;
        split_value <= 0;
        split_control <= 0;
        sensor_data <= 0;
        interrupt <= 0;
        error <= 0;
        file_num <=0;
        file_write <= 0;
        file_read <=0;
        file_write_data <=0;
        dtree_output <= 0;
        sample_count <=0;
        file_data_in <=0;
        equation_done <= 0;
        dsp_output0_reg <= 0;
        dsp_output1_reg <= 0;
        dtree_level <= 0;
        dtree_result <= 0;
     end else begin
        case (state)
          STATE_IDLE: begin
             file_num <= split_file;
             file_write <= 0;
             file_read <=0;
             equation_done <= 0;
             if (equation_start) begin
                dtree_level <= 0;
                split_value <= 0;
                split_control <= 0;
                sensor_data <= 0;
                dtree_output <= 0;
                file_write_data <=0;
                dsp_output0_reg <=0;
                state <= STATE_READ_SPLIT_FILE0_0;
                sample_count <= 0;
                error <= 0;
                file_data_in <= 0;
                dtree_result <=0;
             end else begin
                state <= STATE_IDLE;
             end
          end // case: STATE_IDLE

          STATE_READ_SPLIT_FILE0_0: begin
             file_num <= split_file;
             file_read <= 1;
             if (file_active) begin
                state <= STATE_READ_SPLIT_FILE0_DONE_0;
             end else begin
                state <= STATE_READ_SPLIT_FILE0_0;
             end
          end
          STATE_READ_SPLIT_FILE0_DONE_0:begin
             file_read <= 0;
             if (file_active) begin
                state <= STATE_READ_SPLIT_FILE0_DONE_0;
                split_value <= file_read_data;
             end else begin
                state <= STATE_READ_SPLIT_FILE0_1;
             end
          end // case: STATE_READ_INPUT_FILE0_DONE

          STATE_READ_SPLIT_FILE0_1: begin
             file_read <= 1;
             if (file_active) begin
                state <= STATE_READ_SPLIT_FILE0_DONE_1;
             end else begin
                state <= STATE_READ_SPLIT_FILE0_1;
             end
          end

          STATE_READ_SPLIT_FILE0_DONE_1:begin
             file_read <= 0;
             if (file_active) begin
                state <= STATE_READ_SPLIT_FILE0_DONE_1;
                split_control <= file_read_data;
             end else begin
                state <= STATE_READ_DATA_FILE;
             end
          end

          STATE_READ_DATA_FILE: begin
             file_read <= 1;
             if (file_active) begin
                state <= STATE_READ_DATA_FILE_DONE;
             end else begin
                state <= STATE_READ_DATA_FILE;
             end
          end

          STATE_READ_DATA_FILE_DONE:begin
             file_read <= 0;
             if (file_active) begin
                state <= STATE_READ_DATA_FILE_DONE;
                sensor_data <= file_read_data;
             end else begin
                state <= STATE_OPERATION;
             end
          end

          STATE_OPERATION: begin
             sample_count <= sample_count + 1;
             dtree_result <= (sensor_data <= split_value);
             state <= STATE_WRITE_RESULTS_FILE;
             file_num <= output_file;
             equation_done = (wr_ptr == rd_ptr);
          end // case: STATE_OPERATION

          STATE_WRITE_RESULTS_FILE: begin
             file_write <= 1;
             dsp_output0_reg <= dtree_output[31:0];

             file_write_data <= dtree_output[31:0];
             if (file_active) begin
                state <= STATE_WRITE_RESULTS_FILE_DONE;
             end else begin
                state <= STATE_WRITE_RESULTS_FILE;
             end
          end
          STATE_WRITE_RESULTS_FILE_DONE:begin
             file_write <= 0;
             if (file_active) begin
                state <= STATE_WRITE_RESULTS_FILE_DONE;
             end else begin
                state <= STATE_IDLE;
             end
          end // case: STATE_WRITE_RESULTS_FILE_DONE


          default:begin
             state <= STATE_IDLE;
          end
        endcase // case (state)

     end

`ifdef SIM
   reg [(32*8)-1:0] state_name;
   always @(*) begin
      case (state)
        STATE_IDLE: state_name = "STATE_IDLE";
        STATE_READ_SPLIT_FILE0_0 : state_name = "STATE_READ_SPLIT_FILE0_0";
        STATE_READ_SPLIT_FILE0_DONE_0: state_name = "STATE_READ_SPLIT_FILE0_DONE_0";
        STATE_READ_SPLIT_FILE0_1 : state_name = "STATE_READ_SPLIT_FILE0_1";
        STATE_READ_SPLIT_FILE0_DONE_1: state_name = "STATE_READ_SPLIT_FILE0_DONE_1";
        STATE_READ_DATA_FILE: state_name = "STATE_READ_DATA_FILE";
        STATE_READ_DATA_FILE_DONE: state_name = "STATE_READ_DATA_FILE_DONE";


        STATE_OPERATION: state_name = "STATE_OPERATION";
        STATE_WRITE_RESULTS_FILE: state_name = "STATE_WRITE_RESULTS_FILE";
        STATE_WRITE_RESULTS_FILE_DONE: state_name = "STATE_WRITE_RESULTS_FILE_DONE";
//        : state_name = "";

        default: state_name = "DEFAULT";
      endcase // case (state)
   end
`endif

endmodule // dsp_equation_dtree
