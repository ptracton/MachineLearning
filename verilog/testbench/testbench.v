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

   wire        daq_active;
   wire [31:0] daq_data_rd;
   reg         daq_start;
   reg [31:0]  daq_address;
   reg [3:0]   daq_selection;
   reg         daq_write;
   reg [31:0]  daq_data_wr;

   wire        cpu_active;
   wire [31:0] cpu_data_rd;
   reg         cpu_start;
   reg [31:0]  cpu_address;
   reg [3:0]   cpu_selection;
   reg         cpu_write;
   reg [31:0]  cpu_data_wr;

   reg [7:0]   file_num;
   reg         file_write;
   reg         file_read;
   reg [31:0]  file_write_data;
   wire [31:0] file_read_data;
   wire        file_active;

   top dut(
           // Outputs
           .dtb_pad(dtb_pad),

           .daq_data_rd(daq_data_rd),
           .daq_active(daq_active),

           .file_active(file_active),

           .cpu_data_rd(cpu_data_rd),
           .cpu_active(cpu_active),

           // Inputs
           .clk_pad_i(wb_clk),
           .rst_pad_i(wb_rst),

           .file_num(file_num),
           .file_read(file_read),
           .file_write(file_write),
           .file_write_data(file_write_data),
           .file_read_data(file_read_data),

           .daq_start(daq_start),
           .daq_address(daq_address),
           .daq_selection(daq_selection),
           .daq_write(daq_write),
           .daq_data_wr(daq_data_wr),

           .cpu_start(cpu_start),
           .cpu_address(cpu_address),
           .cpu_selection(cpu_selection),
           .cpu_write(cpu_write),
           .cpu_data_wr(cpu_data_wr)
           ) ;

   initial begin
      daq_start <= 0;
      daq_address <= 0;
      daq_selection <= 0;
      daq_write <=0;
      daq_data_wr <=0;

      cpu_start <= 0;
      cpu_address <= 0;
      cpu_selection <= 0;
      cpu_write <=0;
      cpu_data_wr <=0;

      file_num <= 0;
      file_read <=0;
      file_write <=0;
      file_write_data <= 0;
   end

   //
   // DSP Support Tasks
   //
   dsp_tasks dsp_tasks();


   //
   // Tasks used to help test cases
   //
   test_tasks test_tasks();

   //
   // The actual test cases that are being tested
   //
   test_case test_case();

endmodule // testbench
