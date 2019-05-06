//                              -*- Mode: Verilog -*-
// Filename        : dsp_sm.v
// Description     : DSP State Machine
// Author          : Phil Tracton
// Created On      : Mon Apr 22 16:38:34 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 22 16:38:34 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "dsp_includes.vh"

module dsp_sm (/*AUTOARG*/
   // Outputs
   file_read_data, address, start, selection, write, data_wr,
   file_active, dsp_output0_reg, dsp_output1_reg, dsp_output2_reg,
   dsp_output3_reg, dsp_output4_reg, rd_ptr, wr_ptr,
   // Inputs
   wb_clk, wb_rst, file_num, file_write, file_read, file_reset,
   file_write_data, data_rd, active, dsp_input0_reg, dsp_input1_reg,
   dsp_input2_reg, dsp_input3_reg, dsp_input4_reg
   ) ;
   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;

   input [7:0] file_num;
   input       file_write;
   input       file_read;
   input       file_reset;

   input [31:0] file_write_data;
   output reg [31:0] file_read_data;

   output reg [aw-1:0] address;
   output reg          start;
   output reg [3:0]    selection;
   output reg          write;
   output reg [dw-1:0] data_wr;
   output reg          file_active;

   input [dw-1:0]      data_rd;
   input               active;

   //
   // Read Write Registers
   //
   input [dw-1:0]      dsp_input0_reg;
   input [dw-1:0]      dsp_input1_reg;
   input [dw-1:0]      dsp_input2_reg;
   input [dw-1:0]      dsp_input3_reg;
   input [dw-1:0]      dsp_input4_reg;

   //
   // Read Only Registers
   //
   output reg [dw-1:0] dsp_output0_reg;
   output reg [dw-1:0] dsp_output1_reg;
   output reg [dw-1:0] dsp_output2_reg;
   output reg [dw-1:0] dsp_output3_reg;
   output reg [dw-1:0] dsp_output4_reg;


   reg [7:0]           state;
   localparam STATE_IDLE              = 8'h00;
   localparam STATE_READ_START        = 8'h01;
   localparam STATE_READ_START_DONE   = 8'h02;
   localparam STATE_READ_END          = 8'h03;
   localparam STATE_READ_END_DONE     = 8'h04;
   localparam STATE_READ_RD_PTR       = 8'h05;
   localparam STATE_READ_RD_PTR_DONE  = 8'h06;
   localparam STATE_READ_WR_PTR       = 8'h07;
   localparam STATE_READ_WR_PTR_DONE  = 8'h08;
   localparam STATE_READ_STATUS       = 8'h09;
   localparam STATE_READ_STATUS_DONE  = 8'h0A;
   localparam STATE_READ_CONTROL      = 8'h0B;
   localparam STATE_READ_CONTROL_DONE = 8'h0C;
   localparam STATE_READ_FILE_DATA       = 8'h0D;
   localparam STATE_READ_FILE_DATA_DONE  = 8'h0E;
   localparam STATE_WRITE_FILE_DATA       = 8'h0F;
   localparam STATE_WRITE_FILE_DATA_DONE  = 8'h10;
   localparam STATE_WRITE_STATUS         = 8'h11;
   localparam STATE_WRITE_STATUS_DONE    = 8'h12;
   localparam STATE_WRITE_RD_PTR         = 8'h13;
   localparam STATE_WRITE_RD_PTR_DONE    = 8'h14;
   localparam STATE_WRITE_WR_PTR         = 8'h15;
   localparam STATE_WRITE_WR_PTR_DONE    = 8'h16;
   localparam STATE_RESET_FILE           = 8'h17;

   reg [31:0]          file_base_address;
   reg [31:0]          start_address;
   reg [31:0]          end_address;
   output reg [31:0]   rd_ptr;
   output reg [31:0]   wr_ptr;
   reg [31:0]          control;
   reg [31:0]          file_write_data_reg;
   reg [31:0]          status;
   reg                 reset_file;

   wire [1:0]          data_size = control[`F_CONTROL_DATA_SIZE];
   wire [2:0]          data_size_increment = (data_size == `B_CONTROL_DATA_SIZE_WORD) ? 3'h4 :
                       (data_size == `B_CONTROL_DATA_SIZE_HWORD) ? 3'h2 :
                       (data_size == `B_CONTROL_DATA_SIZE_BYTE) ? 3'h1 :
                       (data_size == `B_CONTROL_DATA_SIZE_UNDEFINED) ? 3'h0 : 3'h0;
   wire [3:0]          data_selection = (data_size == `B_CONTROL_DATA_SIZE_WORD) ? 4'hF :
                       (data_size == `B_CONTROL_DATA_SIZE_HWORD) & wr_ptr[1]==0 ? 4'h3 :
                       (data_size == `B_CONTROL_DATA_SIZE_HWORD) & wr_ptr[1]==1? 4'hC :
                       (data_size == `B_CONTROL_DATA_SIZE_BYTE)  & wr_ptr[1:0] ==0 ? 4'h1 :
                       (data_size == `B_CONTROL_DATA_SIZE_BYTE)  & wr_ptr[1:0] ==1 ? 4'h2 :
                       (data_size == `B_CONTROL_DATA_SIZE_BYTE)  & wr_ptr[1:0] ==2 ? 4'h4 :
                       (data_size == `B_CONTROL_DATA_SIZE_BYTE)  & wr_ptr[1:0] ==3 ? 4'h8 :
                       (data_size == `B_CONTROL_DATA_SIZE_UNDEFINED) ? 3'h0 : 3'h0;

   wire [31:0]         data_write = (data_selection == 4'hf) ? file_write_data_reg[31:0] :
                       (data_selection == 4'hc) ? {file_write_data_reg[31:16], 16'b0} :
                       (data_selection == 4'h3) ? {16'b0, file_write_data_reg[15:0]} :
                       (data_selection == 4'h8) ? {file_write_data_reg[31:24], 24'b0} :
                       (data_selection == 4'h4) ? {8'b0, file_write_data_reg[23:16], 16'b0} :
                       (data_selection == 4'h2) ? {16'b0, file_write_data_reg[15:08], 8'b0} :
                       (data_selection == 4'h1) ? {24'b0, file_write_data_reg[07:00]} : 0;

   reg                 srm;
   reg                 read_not_write;

   function start_read_memory;
      input [31:0]     srm_address;
      input [3:0]      srm_selection;
      begin
         address = srm_address;
         start = 1;
         selection = srm_selection;
         write =0;
         data_wr = 0;
      end
   endfunction // start_read_memory

   function start_write_memory;
      input [31:0] swm_address;
      input [31:0] swm_data;
      input [3:0]  swm_selection;
      begin
         address = swm_address;
         start = 1;
         selection = swm_selection;
         write =1;
         data_wr = swm_data;
      end
   endfunction // start_write_memory

   always @(posedge wb_clk) begin
      if (wb_rst) begin
         file_read_data <=0;
         address <=0;
         start <=0;
         selection <=0;
         write <=0;
         data_wr <=0;
         state <= STATE_IDLE;
         file_base_address <= 0;
         start_address <= 0;
         end_address <=0;
         rd_ptr <=0;
         wr_ptr <=0;
         control <=0;
         file_write_data_reg <= 0;
         status <= 0;
         file_active <=0;
         srm <= 0;
         dsp_output0_reg <= 0;
         dsp_output1_reg <= 0;
         dsp_output2_reg <= 0;
         dsp_output3_reg <= 0;
         dsp_output4_reg <= 0;
         read_not_write <= 0;
         reset_file <= 0;

      end else begin
         case (state)
           STATE_IDLE: begin
              file_read_data <=0;
              address <=0;
              start <=0;
              selection <=0;
              write <=0;
              data_wr <=0;
              file_active <= 0;
              read_not_write <= 0;
              reset_file <= file_reset;

              // Don't clear these in case ew do another of the same file and we can skip stuff
              // file_base_address <= 0;
              // start_address <= 0;
              // end_address <=0;
              // rd_ptr <=0;
              // wr_ptr <=0;
              // control <=0;
              if (file_read | file_write | file_reset) begin
                 read_not_write <= file_read;
                 file_active <= 1;
                 state <= STATE_READ_START;
                 file_base_address <= `WB_RAM0 + 'h20*file_num;
                 file_write_data_reg <= file_write_data;
              end
           end // case: STATE_IDLE

           STATE_READ_START: begin
              srm = start_read_memory(file_base_address+`FILE_START_ADDRESS_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_START_DONE;
              end
           end

           STATE_READ_START_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_READ_END;
                 start_address <= data_rd;
              end
           end

           STATE_READ_END: begin
              srm = start_read_memory(file_base_address+`FILE_END_ADDRESS_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_END_DONE;
              end
           end

           STATE_READ_END_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_READ_RD_PTR;
                 end_address <= data_rd;
              end
           end

           STATE_READ_RD_PTR: begin
              srm = start_read_memory(file_base_address+`FILE_RD_PTR_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_RD_PTR_DONE;
              end
           end

           STATE_READ_RD_PTR_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_READ_WR_PTR;
                 rd_ptr <= data_rd;
              end
           end

           STATE_READ_WR_PTR: begin
              srm = start_read_memory(file_base_address+`FILE_WR_PTR_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_WR_PTR_DONE;
              end
           end

           STATE_READ_WR_PTR_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_READ_STATUS;
                 wr_ptr <= data_rd;
              end
           end

           STATE_READ_STATUS: begin
              srm = start_read_memory(file_base_address+`FILE_STATUS_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_STATUS_DONE;
              end
           end

           STATE_READ_STATUS_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_READ_CONTROL;
                 status <= data_rd;
              end
           end

           STATE_READ_CONTROL: begin
              srm = start_read_memory(file_base_address+`FILE_CONTROL_OFFSET , 4'hF);
              if (active) begin
                 state <= STATE_READ_CONTROL_DONE;
              end
           end

           STATE_READ_CONTROL_DONE: begin
              start <= 0;
              if (!active) begin
                 if (read_not_write) begin
                    if (reset_file) begin
                       state <= STATE_RESET_FILE;
                    end else begin
                       state <= STATE_READ_FILE_DATA;
                    end
                 end else begin
                    if (reset_file) begin
                       state <= STATE_RESET_FILE;
                    end else begin
                       state <= STATE_WRITE_FILE_DATA;
                    end
                 end
                 control <= data_rd;
              end
           end // case: STATE_READ_CONTROL_DONE

           STATE_READ_FILE_DATA : begin
              // srm = start_write_memory(wr_ptr, file_write_data_reg, data_selection);
              srm = start_read_memory(rd_ptr, data_selection);
              if (active) begin
                 write <=0;
                 state <= STATE_READ_FILE_DATA_DONE;
                 // increment pointer and deal with wrap around
                 rd_ptr = rd_ptr + data_size_increment;
                 if (rd_ptr > end_address) begin
                    rd_ptr = start_address;
                    status[`F_STATUS_WRAP_AROUND] = 1;
                 end
              end
           end // case: STATE_READ_FILE_DATA


           STATE_READ_FILE_DATA_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_WRITE_STATUS;
                 file_read_data <= data_rd;
              end
           end

           STATE_WRITE_FILE_DATA : begin
              // srm = start_write_memory(wr_ptr, file_write_data_reg, data_selection);
              srm = start_write_memory(wr_ptr, file_write_data_reg, data_selection);
              if (active) begin
                 write <=0;
                 state <= STATE_WRITE_FILE_DATA_DONE;
                 // increment pointer and deal with wrap around
                 wr_ptr = wr_ptr + data_size_increment;
                 if (wr_ptr > end_address) begin
                    wr_ptr = start_address;
                    status[`F_STATUS_WRAP_AROUND] = 1;
                 end
              end
           end // case: STATE_WRITE_FILE_DATA


           STATE_WRITE_FILE_DATA_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_WRITE_STATUS;
              end
           end

           STATE_WRITE_STATUS : begin
              srm = start_write_memory(file_base_address+`FILE_STATUS_OFFSET, status, 4'hF);
              if (active) begin
                 write <=0;
                 state <= STATE_WRITE_STATUS_DONE;
              end
           end

           STATE_WRITE_STATUS_DONE: begin
              start <= 0;
              if (!active) begin
                 if (read_not_write) begin
                    state <= STATE_WRITE_RD_PTR;
                 end else begin
                    state <= STATE_WRITE_WR_PTR;
                 end
              end
           end

           STATE_WRITE_RD_PTR : begin
              srm = start_write_memory(file_base_address+`FILE_RD_PTR_OFFSET, rd_ptr, 4'hF);
              if (active) begin
                 write <=0;
                 state <= STATE_WRITE_RD_PTR_DONE;
              end
           end

           STATE_WRITE_WR_PTR_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_IDLE;
              end
           end

           STATE_WRITE_WR_PTR : begin
              srm = start_write_memory(file_base_address+`FILE_WR_PTR_OFFSET, wr_ptr, 4'hF);
              if (active) begin
                 write <=0;
                 state <= STATE_WRITE_WR_PTR_DONE;
              end
           end

           STATE_WRITE_WR_PTR_DONE: begin
              start <= 0;
              if (!active) begin
                 state <= STATE_IDLE;
              end
           end

           STATE_RESET_FILE: begin
              rd_ptr <= start_address;
              wr_ptr <= start_address;
              state <= STATE_WRITE_RD_PTR;
           end

           default: begin
              state <= STATE_IDLE;
           end

         endcase // case (state)
      end // else: !if(wb_rst)
   end // always @ (posedge wb_clk)


`ifdef SIM
   reg [32*8-1:0] state_name;
   always @(*)
     case (state)
       STATE_IDLE:           state_name     = "IDLE";
       STATE_READ_START:     state_name     = "READ START";
       STATE_READ_START_DONE:state_name     = "READ START DONE";
       STATE_READ_END:     state_name     = "READ END";
       STATE_READ_END_DONE:state_name     = "READ END DONE";
       STATE_READ_RD_PTR:     state_name     = "READ RD_PTR";
       STATE_READ_RD_PTR_DONE:state_name     = "READ RD_PTR DONE";
       STATE_READ_WR_PTR:     state_name     = "READ WR_PTR";
       STATE_READ_WR_PTR_DONE:state_name     = "READ WR_PTR DONE";
       STATE_READ_STATUS:     state_name     = "READ STATUS";
       STATE_READ_STATUS_DONE:state_name     = "READ STATUS DONE";
       STATE_READ_CONTROL:     state_name     = "READ CONTROL";
       STATE_READ_CONTROL_DONE:state_name     = "READ CONTROL DONE";
       STATE_READ_FILE_DATA:     state_name     = "READ DATA";
       STATE_READ_FILE_DATA_DONE:state_name     = "READ DATA DONE";
       STATE_WRITE_FILE_DATA:     state_name     = "WRITE DATA";
       STATE_WRITE_FILE_DATA_DONE:state_name     = "WRITE DATA DONE";
       STATE_WRITE_STATUS:     state_name     = "WRITE STATUS";
       STATE_WRITE_STATUS_DONE:state_name     = "WRITE STATUS DONE";
       STATE_WRITE_RD_PTR:     state_name     = "WRITE RD PTR";
       STATE_WRITE_RD_PTR_DONE:state_name     = "WRITE RD PTR DONE";
       STATE_WRITE_WR_PTR:     state_name     = "WRITE WR PTR";
       STATE_WRITE_WR_PTR_DONE:state_name     = "WRITE WR PTR DONE";
       STATE_RESET_FILE:state_name     = "RESET FILE";


       default:              state_name     = "DEFAULT";
     endcase // case (state)

`endif

endmodule // dsp_sm
