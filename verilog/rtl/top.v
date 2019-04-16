//                              -*- Mode: Verilog -*-
// Filename        : top.v
// Description     : Simpler DSP/ML Testing Modules
// Author          : Phil Tracton
// Created On      : Mon Apr 15 15:39:03 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 15 15:39:03 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "timescale.v"

module top (/*AUTOARG*/
   // Outputs
   dtb_pad, data_rd, active,
   // Inputs
   clk_pad_i, rst_pad_i, file_num, file_write, file_read, address,
   start, selection, write, data_wr
   ) ;

   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input clk_pad_i;
   input rst_pad_i;
   output [31:0] dtb_pad;

   input [7:0]   file_num;
   input         file_write;
   input         file_read;
   input [aw-1:0]  address;
   input           start;
   input [3:0]     selection;
   input           write;
   input [dw-1:0]  data_wr;
   output [dw-1:0] data_rd;
   output          active;

   /*AUTOWIRE*/


   // Beginning of automatic regs (for this module's undeclared outputs)
   wire            active;
   wire [dw-1:0]   data_rd;
   wire [31:0]     dtb_pad;
   // End of automatics

   syscon syscon0(
                  // Outputs
                  .wb_clk_o(wb_clk),
                  .wb_rst_o(wb_rst),
                  // Inputs
                  .clk_pad_i(clk_pad_i),
                  .rst_pad_i(rst_pad_i)
                  ) ;


`include "bus_matrix.vh"

   daq_top daq(
               // Outputs
               .wb_m_adr_o(wb_m2s_daq_master_adr),
               .wb_m_dat_o(wb_m2s_daq_master_dat),
               .wb_m_sel_o(wb_m2s_daq_master_sel),
               .wb_m_we_o(wb_m2s_daq_master_we),
               .wb_m_cyc_o(wb_m2s_daq_master_cyc),
               .wb_m_stb_o(wb_m2s_daq_master_stb),
               .wb_m_cti_o(wb_m2s_daq_master_cti),
               .wb_m_bte_o(wb_m2s_daq_master_bte),

               .data_rd(data_rd),
               .active(active),

               .wb_s_dat_o(wb_s2m_daq_slave_dat),
               .wb_s_ack_o(wb_s2m_daq_slave_ack),
               .wb_s_err_o(wb_s2m_daq_slave_err),
               .wb_s_rty_o(wb_s2m_daq_slave_rty),

               // Inputs
               .wb_clk(wb_clk),
               .wb_rst(wb_rst),
               .wb_m_dat_i(wb_s2m_daq_master_dat),
               .wb_m_ack_i(wb_s2m_daq_master_ack),
               .wb_m_err_i(wb_s2m_daq_master_err),
               .wb_m_rty_i(wb_s2m_daq_master_rty),

               .start(start),
               .address(address),
               .selection(selection),
               .write(write),
               .data_wr(data_wr),

               .wb_s_adr_i(wb_m2s_daq_slave_adr),
               .wb_s_dat_i(wb_m2s_daq_slave_dat),
               .wb_s_sel_i(wb_m2s_daq_slave_sel),
               .wb_s_we_i(wb_m2s_daq_slave_we),
               .wb_s_cyc_i(wb_m2s_daq_slave_cyc),
               .wb_s_stb_i(wb_m2s_daq_slave_stb),
               .wb_s_cti_i(wb_m2s_daq_slave_cti),
               .wb_s_bte_i(wb_m2s_daq_slave_bte)
               ) ;

   dsp_top dsp(
               // Outputs
               .wb_m_adr_o(wb_m2s_dsp_master_adr),
               .wb_m_dat_o(wb_m2s_dsp_master_dat),
               .wb_m_sel_o(wb_m2s_dsp_master_sel),
               .wb_m_we_o(wb_m2s_dsp_master_we),
               .wb_m_cyc_o(wb_m2s_dsp_master_cyc),
               .wb_m_stb_o(wb_m2s_dsp_master_stb),
               .wb_m_cti_o(wb_m2s_dsp_master_cti),
               .wb_m_bte_o(wb_m2s_dsp_master_bte),

               .wb_s_dat_o(wb_s2m_dsp_slave_dat),
               .wb_s_ack_o(wb_s2m_dsp_slave_ack),
               .wb_s_err_o(wb_s2m_dsp_slave_err),
               .wb_s_rty_o(wb_s2m_dsp_slave_rty),

               // Inputs
               .wb_clk(wb_clk),
               .wb_rst(wb_rst),
               .wb_m_dat_i(wb_s2m_dsp_master_dat),
               .wb_m_ack_i(wb_s2m_dsp_master_ack),
               .wb_m_err_i(wb_s2m_dsp_master_err),
               .wb_m_rty_i(wb_s2m_dsp_master_rty),

               .wb_s_adr_i(wb_m2s_dsp_slave_adr),
               .wb_s_dat_i(wb_m2s_dsp_slave_dat),
               .wb_s_sel_i(wb_m2s_dsp_slave_sel),
               .wb_s_we_i(wb_m2s_dsp_slave_we),
               .wb_s_cyc_i(wb_m2s_dsp_slave_cyc),
               .wb_s_stb_i(wb_m2s_dsp_slave_stb),
               .wb_s_cti_i(wb_m2s_dsp_slave_cti),
               .wb_s_bte_i(wb_m2s_dsp_slave_bte)
               ) ;



   wb_ram
     #(.depth(8192))
   ram0
     (	   .wb_clk_i(wb_clk),
           .wb_rst_i(wb_rst),

           .wb_adr_i(wb_m2s_ram0_adr[12:0]),
           .wb_dat_i(wb_m2s_ram0_dat),
           .wb_sel_i(wb_m2s_ram0_sel),
           .wb_we_i(wb_m2s_ram0_we),
           .wb_bte_i(wb_m2s_ram0_bte),
           .wb_cti_i(wb_m2s_ram0_cti),
           .wb_cyc_i(wb_m2s_ram0_cyc),
           .wb_stb_i(wb_m2s_ram0_stb),

           .wb_ack_o(wb_s2m_ram0_ack),
           .wb_err_o(wb_s2m_ram0_err),
           .wb_dat_o(wb_s2m_ram0_dat)
           );

   wb_ram
     #(.depth(8192))
   ram1
     (	   .wb_clk_i(wb_clk),
           .wb_rst_i(wb_rst),

           .wb_adr_i(wb_m2s_ram1_adr[12:0]),
           .wb_dat_i(wb_m2s_ram1_dat),
           .wb_sel_i(wb_m2s_ram1_sel),
           .wb_we_i(wb_m2s_ram1_we),
           .wb_bte_i(wb_m2s_ram1_bte),
           .wb_cti_i(wb_m2s_ram1_cti),
           .wb_cyc_i(wb_m2s_ram1_cyc),
           .wb_stb_i(wb_m2s_ram1_stb),

           .wb_ack_o(wb_s2m_ram1_ack),
           .wb_err_o(wb_s2m_ram1_err),
           .wb_dat_o(wb_s2m_ram1_dat)
           );

   wb_ram
     #(.depth(8192))
   ram2
     (	   .wb_clk_i(wb_clk),
           .wb_rst_i(wb_rst),

           .wb_adr_i(wb_m2s_ram2_adr[12:0]),
           .wb_dat_i(wb_m2s_ram2_dat),
           .wb_sel_i(wb_m2s_ram2_sel),
           .wb_we_i(wb_m2s_ram2_we),
           .wb_bte_i(wb_m2s_ram2_bte),
           .wb_cti_i(wb_m2s_ram2_cti),
           .wb_cyc_i(wb_m2s_ram2_cyc),
           .wb_stb_i(wb_m2s_ram2_stb),

           .wb_ack_o(wb_s2m_ram2_ack),
           .wb_err_o(wb_s2m_ram2_err),
           .wb_dat_o(wb_s2m_ram2_dat)
           );

   wb_ram
     #(.depth(8192))
   ram3
     (	   .wb_clk_i(wb_clk),
           .wb_rst_i(wb_rst),

           .wb_adr_i(wb_m2s_ram3_adr[12:0]),
           .wb_dat_i(wb_m2s_ram3_dat),
           .wb_sel_i(wb_m2s_ram3_sel),
           .wb_we_i(wb_m2s_ram3_we),
           .wb_bte_i(wb_m2s_ram3_bte),
           .wb_cti_i(wb_m2s_ram3_cti),
           .wb_cyc_i(wb_m2s_ram3_cyc),
           .wb_stb_i(wb_m2s_ram3_stb),

           .wb_ack_o(wb_s2m_ram3_ack),
           .wb_err_o(wb_s2m_ram3_err),
           .wb_dat_o(wb_s2m_ram3_dat)
           );


endmodule // top
