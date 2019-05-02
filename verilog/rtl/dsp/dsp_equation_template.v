//                              -*- Mode: Verilog -*-
// Filename        : dsp_equation_dtree.v
// Description     : Decision Tree
// Author          : Philip Tracton
// Created On      : Tue Apr 30 17:13:07 2019
// Last Modified By: Philip Tracton
// Last Modified On: Tue Apr 30 17:13:07 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module dtree (/*AUTOARG*/
   // Outputs
   interrupt, error, file_num, file_write, file_read, file_write_data,
   equation_done, dsp_output0_reg, dsp_output1_reg, dsp_output2_reg,
   dsp_output3_reg, dsp_output4_reg,
   // Inputs
   wb_clk, wb_rst, equation_enable, dsp_input0_reg, dsp_input1_reg,
   dsp_input2_reg, dsp_input3_reg, dsp_input4_reg, file_read_data,
   file_active, rd_ptr, wr_ptr
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
   input [dw-1:0] dsp_input4_reg;

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
   output reg [31:0] dsp_output2_reg;
   output reg [31:0] dsp_output3_reg;
   output reg [31:0] dsp_output4_reg;

   wire              equation_start = dsp_input0_reg[`F_DSP_SLAVE_EQUATION_START] & equation_enable;
   wire [1:0]        data_size =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIZE];
   wire              data_signed =dsp_input0_reg[`F_DSP_SLAVE_DATA_SIGNED];
   wire              enable_mac = dsp_input0_reg[`F_DSP_SLAVE_ENABLE_MAC];
   wire              scalar_multiply = dsp_input0_reg[`F_DSP_SLAVE_SCALAR_MULTIPLY];

   wire [7:0]        input_file0 = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE0];
   wire [7:0]        input_file1 = dsp_input1_reg[`F_DSP_SLAVE_INPUT_FILE1];
   wire [7:0]        output_file = dsp_input3_reg[`F_DSP_SLAVE_OUTPUT_FILE0];

   localparam STATE_IDLE                    = 8'h00;
   localparam STATE_READ_INPUT_FILE0        = 8'h01;
   localparam STATE_READ_INPUT_FILE0_DONE   = 8'h02;

   reg [7:0]         state;
   reg [31:0]        sample_count;
   reg [31:0]        file_data_in;

   always @(posedge wb_clk)
     if (wb_rst) begin
        state <= STATE_IDLE;
        interrupt <= 0;
        error <= 0;
        file_num <=0;
        file_write <= 0;
        file_read <=0;
        file_write_data <=0;
        multiply_output <= 0;
        mac_output <=0;
        sample_count <=0;
        file_data_in <=0;
        equation_done <= 0;
        dsp_output0_reg <= 0;
        dsp_output1_reg <= 0;
        dsp_output2_reg <= 0;
        dsp_output3_reg <= 0;
        dsp_output4_reg <= 0;


     end else begin
        case (state)
          STATE_IDLE: begin
             file_num <= input_file0;
             file_write <= 0;
             file_read <=0;
             equation_done <= 0;
             if (equation_start) begin
                file_write_data <=0;
                dsp_output0_reg <=0;
                dsp_output1_reg <=0;
                dsp_output2_reg <=0;
                dsp_output3_reg <=0;
                dsp_output4_reg <=0;
                state <= STATE_READ_INPUT_FILE0;

                sample_count <= 0;
                error <= 0;
                file_data_in <= 0;

             end else begin
                state <= STATE_IDLE;
             end
          end // case: STATE_IDLE

          STATE_READ_INPUT_FILE0: begin
             file_num <= input_file0;
             file_read <= 1;
             if (file_active) begin
                state <= STATE_READ_INPUT_FILE0_DONE;
             end else begin
                state <= STATE_READ_INPUT_FILE0;
             end
          end
          STATE_READ_INPUT_FILE0_DONE:begin
             file_read <= 0;
             if (file_active) begin
                state <= STATE_READ_INPUT_FILE0_DONE;
                operand0 <= file_read_data;
             end else begin
                file_num <= input_file1;
                   state <= STATE_READ_INPUT_FILE1;
                end
             end
          end // case: STATE_READ_INPUT_FILE0_DONE

          default:begin
             state <= STATE_IDLE;
          end

        endcase // case (state)
     end // else: !if(wb_rst)


`ifdef SIM
   reg [(32*8)-1:0] state_name;
   always @(*) begin
      case (state)
        STATE_IDLE: state_name = "STATE_IDLE";
        STATE_READ_INPUT_FILE0 : state_name = "STATE_READ_INPUT_FILE0";
        STATE_READ_INPUT_FILE0_DONE: state_name = "STATE_READ_INPUT_FILE0_DONE";
        default: state_name = "DEFAULT";
      endcase // case (state)
   end
`endif

endmodule // dtree
