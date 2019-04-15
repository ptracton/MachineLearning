//                              -*- Mode: Verilog -*-
// Filename        : dsp_top.v
// Description     : DSP Top
// Author          : Phil Tracton
// Created On      : Mon Apr 15 16:46:09 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 15 16:46:09 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module dsp_top (/*AUTOARG*/
                // Outputs
                wb_m_adr_o, wb_m_dat_o, wb_m_sel_o, wb_m_we_o, wb_m_cyc_o,
                wb_m_stb_o, wb_m_cti_o, wb_m_bte_o, wb_s_dat_o, wb_s_ack_o,
                wb_s_err_o, wb_s_rty_o,
                // Inputs
                wb_clk, wb_rst, wb_m_dat_i, wb_m_ack_i, wb_m_err_i, wb_m_rty_i,
                wb_s_adr_i, wb_s_dat_i, wb_s_sel_i, wb_s_we_i, wb_s_cyc_i,
                wb_s_stb_i, wb_s_cti_i, wb_s_bte_i
                ) ;
   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input 		wb_clk;
   input 		wb_rst;
   output wire [aw-1:0] wb_m_adr_o;
   output wire [dw-1:0] wb_m_dat_o;
   output wire [3:0]    wb_m_sel_o;
   output wire          wb_m_we_o ;
   output wire          wb_m_cyc_o;
   output wire          wb_m_stb_o;
   output wire [2:0]    wb_m_cti_o;
   output wire [1:0]    wb_m_bte_o;
   input [dw-1:0]       wb_m_dat_i;
   input                wb_m_ack_i;
   input                wb_m_err_i;
   input                wb_m_rty_i;


   input wire [aw-1:0]  wb_s_adr_i;
   input wire [dw-1:0]  wb_s_dat_i;
   input wire [3:0]     wb_s_sel_i;
   input wire           wb_s_we_i ;
   input wire           wb_s_cyc_i;
   input wire           wb_s_stb_i;
   input wire [2:0]     wb_s_cti_i;
   input wire [1:0]     wb_s_bte_i;

   output wire [dw-1:0] wb_s_dat_o;
   output wire          wb_s_ack_o;
   output wire          wb_s_err_o;
   output wire          wb_s_rty_o;

   wb_master_interface master(
                              // Outputs
                              .wb_adr_o(wb_m_adr_o),
                              .wb_dat_o(wb_m_dat_o),
                              .wb_sel_o(wb_m_sel_o),
                              .wb_we_o(wb_m_we_o),
                              .wb_cyc_o(wb_m_cyc_o),
                              .wb_stb_o(wb_m_stb_o),
                              .wb_cti_o(wb_m_cti_o),
                              .wb_bte_o(wb_m_bte_o),

                              .data_rd(data_rd),
                              .active(active),

                              // Inputs
                              .wb_clk(wb_clk),
                              .wb_rst(wb_rst),
                              .wb_dat_i(wb_m_dat_i),
                              .wb_ack_i(wb_m_ack_i),
                              .wb_err_i(wb_m_err_i),
                              .wb_rty_i(wb_m_rty_i),

                              .start(start),
                              .address(address),
                              .selection(selection),
                              .write(write),
                              .data_wr(data_wr)
                              ) ;

   dsp_slave slave(
                   // Outputs
                   .wb_dat_o(wb_s_dat_o),
                   .wb_ack_o(wb_s_ack_o),
                   .wb_err_o(wb_s_err_o),
                   .wb_rty_o(wb_s_rty_o),
                   // Inputs
                   .wb_clk(wb_clk),
                   .wb_rst(wb_rst),
                   .wb_adr_i(wb_s_adr_i),
                   .wb_dat_i(wb_s_dat_i),
                   .wb_sel_i(wb_s_sel_i),
                   .wb_we_i(wb_s_we_i),
                   .wb_cyc_i(wb_s_cyc_i),
                   .wb_stb_i(wb_s_stb_i),
                   .wb_cti_i(wb_s_cti_i),
                   .wb_bte_i(wb_s_bte_i)
                   ) ;

endmodule // dsp_top
