//                              -*- Mode: Verilog -*-
// Filename        : daq_sm.v
// Description     : Data Aquisition State machine
// Author          : Phil Tracton
// Created On      : Tue Apr 16 17:59:12 2019
// Last Modified By: Phil Tracton
// Last Modified On: Tue Apr 16 17:59:12 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module daq_sm (/*AUTOARG*/
   // Outputs
   file_read_data, address, start, selection, write, data_wr,
   // Inputs
   wb_clk, wb_rst, file_num, file_write, file_read, file_write_data,
   data_rd, active
   ) ;
   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;

   input [7:0] file_num;
   input       file_write;
   input       file_read;
   input [31:0] file_write_data;
   output reg [31:0] file_read_data;

   output reg [aw-1:0] address;
   output reg          start;
   output reg [3:0]    selection;
   output reg          write;
   output reg [dw-1:0] data_wr;

   input [dw-1:0] data_rd;
   input          active;


   reg [7:0]     state;
   localparam STATE_IDLE            = 8'h00;
   localparam STATE_READ_START      = 8'h01;
   localparam STATE_READ_START_DONE = 8'h02;

   always @(posedge wb_clk) begin
      if (wb_rst) begin
         file_read_data <=0;
         address <=0;
         start <=0;
         selection <=0;
         write <=0;
         data_wr <=0;
         state <= STATE_IDLE;

      end else begin
         case (state)
           STATE_IDLE: begin
              file_read_data <=0;
              address <=0;
              start <=0;
              selection <=0;
              write <=0;
              data_wr <=0;
              if (file_read | file_write) begin
                 state <= STATE_READ_START;
              end
           end // case: STATE_IDLE

           STATE_READ_START: begin
           end

           STATE_READ_START_DONE: begin
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
       default:              state_name     = "DEFAULT";
     endcase // case (state)

`endif
endmodule // daq_sm
