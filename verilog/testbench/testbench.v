//                              -*- Mode: Verilog -*-
// Filename        : testbench.v
// Description     : Wishbone DSP Testbench
// Author          : Philip Tracton
// Created On      : Wed Dec  2 13:12:45 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed Dec  2 13:12:45 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "timescale.v"
`include "dsp_includes.vh"

module testbench (/*AUTOARG*/ ) ;

   //
   // Creates a clock, reset, a timeout in case the sim never stops,
   // and pass/fail managers
   //
`include "test_management.v"

   //
   // Free running system clock
   //
   reg wb_clk;
   initial begin
      wb_clk <= 0;
      forever begin
         #10 wb_clk <= ~wb_clk;
      end
   end

   //
   // System reset
   //
   reg wb_rst;
   initial begin
      wb_rst <= 0;
      #100 wb_rst <= 1;
      #100 wb_rst <= 0;
   end

   wire [31:0] dtb_pad;
   wire        active;
   wire [31:0] data_rd;

   reg         start;
   reg [31:0]  address;
   reg [3:0]   selection;
   reg         write;
   reg [31:0]  data_wr;
   reg [7:0]   file_num;
   reg         file_write;
   reg         file_read;

   top dut(
           // Outputs
           .dtb_pad(dtb_pad),
           .data_rd(data_rd),
           .active(active),

           // Inputs
           .clk_pad_i(wb_clk),
           .rst_pad_i(wb_rst),
           .file_num(file_num),
           .file_read(file_read),
           .file_write(file_write),
           .start(start),
           .address(address),
           .selection(selection),
           .write(write),
           .data_wr(data_wr)
           ) ;

   initial begin
      start <= 0;
      address <= 0;
      selection <= 0;
      write <=0;
      data_wr <=0;
      file_num <= 0;
      file_read <=0;
      file_write <=0;
   end


   //
   // Tasks used to help test cases
   //
   test_tasks test_tasks();

   //
   // The actual test cases that are being tested
   //
   test_case test_case();

endmodule // testbench
