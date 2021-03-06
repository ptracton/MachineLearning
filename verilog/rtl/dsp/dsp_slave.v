//                              -*- Mode: Verilog -*-
// Filename        : dsp_slave.v
// Description     : Data Acquisition Slave
// Author          : Phil Tracton
// Created On      : Mon Apr 15 16:11:29 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 15 16:11:29 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!


`include "timescale.v"
`include "dsp_includes.vh"

module dsp_slave (/*AUTOARG*/
   // Outputs
   wb_dat_o, wb_ack_o, wb_err_o, wb_rty_o, dsp_input0_reg,
   dsp_input1_reg, dsp_input2_reg, dsp_input3_reg, dsp_input4_reg,
   // Inputs
   wb_clk, wb_rst, start, wb_adr_i, wb_dat_i, wb_sel_i, wb_we_i,
   wb_cyc_i, wb_stb_i, wb_cti_i, wb_bte_i, dsp_output0_reg,
   dsp_output1_reg, dsp_output2_reg, dsp_output3_reg, dsp_output4_reg,
   done
   ) ;

   parameter SLAVE_ADDRESS = 32'h0000_0000;
   parameter dw = 32;
   parameter aw = 32;
   parameter DEBUG = 0;

   input wb_clk;
   input wb_rst;
   input start;

   input wire [aw-1:0] wb_adr_i;
   input wire [dw-1:0] wb_dat_i;
   input wire [3:0]    wb_sel_i;
   input wire          wb_we_i ;
   input wire          wb_cyc_i;
   input wire          wb_stb_i;
   input wire [2:0]    wb_cti_i;
   input wire [1:0]    wb_bte_i;

   output reg [dw-1:0] wb_dat_o;
   output reg          wb_ack_o;
   output reg          wb_err_o;
   output reg          wb_rty_o;

   //
   // Read Write Registers
   //
   output reg [dw-1:0] dsp_input0_reg;
   output reg [dw-1:0] dsp_input1_reg;
   output reg [dw-1:0] dsp_input2_reg;
   output reg [dw-1:0] dsp_input3_reg;
   output reg [dw-1:0] dsp_input4_reg;

   //
   // Read Only Registers
   //
   input [dw-1:0]      dsp_output0_reg;
   input [dw-1:0]      dsp_output1_reg;
   input [dw-1:0]      dsp_output2_reg;
   input [dw-1:0]      dsp_output3_reg;
   input [dw-1:0]      dsp_output4_reg;
   input               done;

   wire                write_registers = wb_cyc_i & wb_stb_i & wb_we_i;
   wire                read_registers = wb_cyc_i & wb_stb_i;


   //
   // Bus Cycle Logic
   //
   always @(posedge wb_clk)
     if (wb_rst) begin
        wb_ack_o <= 1'b0;
        wb_err_o <= 1'b0;
        wb_rty_o <= 1'b0;
     end else begin
        if (wb_cyc_i & wb_stb_i) begin
           wb_ack_o <= 1;
        end else begin
           wb_ack_o <= 0;
        end
     end // else: !if(wb_rst)



   //
   // Register Write Logic
   //
   always @(posedge wb_clk)
     if (wb_rst) begin
        dsp_input0_reg <= 32'h0;
        dsp_input1_reg <= 32'h0;
        dsp_input2_reg <= 32'h0;
        dsp_input3_reg <= 32'h0;
        dsp_input4_reg <= 32'h0;

        dsp_input0_reg <= 32'h0;
        dsp_input1_reg <= 32'h0;
        dsp_input2_reg <= 32'h0;
        dsp_input3_reg <= 32'h0;
        dsp_input4_reg <= 32'h0;
     end else begin // if (wb_rst)
        if (write_registers) begin
           case (wb_adr_i[7:0])
             `WB_DSP_SLAVE_INPUT0_OFFSET: begin
                dsp_input0_reg[07:00] <= wb_sel_i[0] ? wb_dat_i[07:00] : dsp_input0_reg[07:00];
                dsp_input0_reg[15:08] <= wb_sel_i[1] ? wb_dat_i[15:08] : dsp_input0_reg[15:08];
                dsp_input0_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : dsp_input0_reg[23:16];
                dsp_input0_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : dsp_input0_reg[31:24];
             end
             `WB_DSP_SLAVE_INPUT1_OFFSET: begin
                dsp_input1_reg[07:00] <= wb_sel_i[0] ? wb_dat_i[07:00] : dsp_input1_reg[07:00];
                dsp_input1_reg[15:08] <= wb_sel_i[1] ? wb_dat_i[15:08] : dsp_input1_reg[15:08];
                dsp_input1_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : dsp_input1_reg[23:16];
                dsp_input1_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : dsp_input1_reg[31:24];
             end
             `WB_DSP_SLAVE_INPUT2_OFFSET: begin
                dsp_input2_reg[07:00] <= wb_sel_i[0] ? wb_dat_i[07:00] : dsp_input2_reg[07:00];
                dsp_input2_reg[15:08] <= wb_sel_i[1] ? wb_dat_i[15:08] : dsp_input2_reg[15:08];
                dsp_input2_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : dsp_input2_reg[23:16];
                dsp_input2_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : dsp_input2_reg[31:24];
             end
             `WB_DSP_SLAVE_INPUT3_OFFSET: begin
                dsp_input3_reg[07:00] <= wb_sel_i[0] ? wb_dat_i[07:00] : dsp_input3_reg[07:00];
                dsp_input3_reg[15:08] <= wb_sel_i[1] ? wb_dat_i[15:08] : dsp_input3_reg[15:08];
                dsp_input3_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : dsp_input3_reg[23:16];
                dsp_input3_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : dsp_input3_reg[31:24];
             end
             `WB_DSP_SLAVE_INPUT4_OFFSET: begin
                dsp_input4_reg[07:00] <= wb_sel_i[0] ? wb_dat_i[07:00] : dsp_input4_reg[07:00];
                dsp_input4_reg[15:08] <= wb_sel_i[1] ? wb_dat_i[15:08] : dsp_input4_reg[15:08];
                dsp_input4_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : dsp_input4_reg[23:16];
                dsp_input4_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : dsp_input4_reg[31:24];
             end
           endcase // case (wb_adr_i[7:0])

        end else begin // if (write_registers)
           if (dsp_input0_reg[`F_DSP_SLAVE_EQUATION_START] ) begin
              // Auto clear this bit
              dsp_input0_reg[`F_DSP_SLAVE_EQUATION_START] <= 1'b0;
           end
        end // else: !if(write_registers)
     end // else: !if(wb_rst)


   //
   // Register Read Logic
   //
   always @(posedge wb_clk)
     if (wb_rst) begin
        wb_dat_o <= 32'b0;
     end else begin
        if (read_registers) begin
           case (wb_adr_i[7:0])
             `WB_DSP_SLAVE_INPUT0_OFFSET:  wb_dat_o <= dsp_input0_reg;
             `WB_DSP_SLAVE_INPUT1_OFFSET:  wb_dat_o <= dsp_input1_reg;
             `WB_DSP_SLAVE_INPUT2_OFFSET:  wb_dat_o <= dsp_input2_reg;
             `WB_DSP_SLAVE_INPUT3_OFFSET:  wb_dat_o <= dsp_input3_reg;
             `WB_DSP_SLAVE_INPUT4_OFFSET:  wb_dat_o <= dsp_input4_reg;
             `WB_DSP_SLAVE_OUTPUT0_OFFSET: wb_dat_o <= dsp_output0_reg;
             `WB_DSP_SLAVE_OUTPUT1_OFFSET: wb_dat_o <= dsp_output1_reg;
             `WB_DSP_SLAVE_OUTPUT2_OFFSET: wb_dat_o <= dsp_output2_reg;
             `WB_DSP_SLAVE_OUTPUT3_OFFSET: wb_dat_o <= dsp_output3_reg;
             `WB_DSP_SLAVE_OUTPUT4_OFFSET: wb_dat_o <= dsp_output4_reg;
           endcase // case (wb_adr_i[7:0])
        end
     end // else: !if(wb_rst)

endmodule // dsp_slave
