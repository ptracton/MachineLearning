// THIS FILE IS AUTOGENERATED BY wb_intercon_gen
// ANY MANUAL CHANGES WILL BE LOST
module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_cpu_master_adr_i,
    input  [31:0] wb_cpu_master_dat_i,
    input   [3:0] wb_cpu_master_sel_i,
    input         wb_cpu_master_we_i,
    input         wb_cpu_master_cyc_i,
    input         wb_cpu_master_stb_i,
    input   [2:0] wb_cpu_master_cti_i,
    input   [1:0] wb_cpu_master_bte_i,
    output [31:0] wb_cpu_master_dat_o,
    output        wb_cpu_master_ack_o,
    output        wb_cpu_master_err_o,
    output        wb_cpu_master_rty_o,
    input  [31:0] wb_daq_master_adr_i,
    input  [31:0] wb_daq_master_dat_i,
    input   [3:0] wb_daq_master_sel_i,
    input         wb_daq_master_we_i,
    input         wb_daq_master_cyc_i,
    input         wb_daq_master_stb_i,
    input   [2:0] wb_daq_master_cti_i,
    input   [1:0] wb_daq_master_bte_i,
    output [31:0] wb_daq_master_dat_o,
    output        wb_daq_master_ack_o,
    output        wb_daq_master_err_o,
    output        wb_daq_master_rty_o,
    input  [31:0] wb_dsp_master_adr_i,
    input  [31:0] wb_dsp_master_dat_i,
    input   [3:0] wb_dsp_master_sel_i,
    input         wb_dsp_master_we_i,
    input         wb_dsp_master_cyc_i,
    input         wb_dsp_master_stb_i,
    input   [2:0] wb_dsp_master_cti_i,
    input   [1:0] wb_dsp_master_bte_i,
    output [31:0] wb_dsp_master_dat_o,
    output        wb_dsp_master_ack_o,
    output        wb_dsp_master_err_o,
    output        wb_dsp_master_rty_o,
    output [31:0] wb_dsp_slave_adr_o,
    output [31:0] wb_dsp_slave_dat_o,
    output  [3:0] wb_dsp_slave_sel_o,
    output        wb_dsp_slave_we_o,
    output        wb_dsp_slave_cyc_o,
    output        wb_dsp_slave_stb_o,
    output  [2:0] wb_dsp_slave_cti_o,
    output  [1:0] wb_dsp_slave_bte_o,
    input  [31:0] wb_dsp_slave_dat_i,
    input         wb_dsp_slave_ack_i,
    input         wb_dsp_slave_err_i,
    input         wb_dsp_slave_rty_i,
    output [31:0] wb_daq_slave_adr_o,
    output [31:0] wb_daq_slave_dat_o,
    output  [3:0] wb_daq_slave_sel_o,
    output        wb_daq_slave_we_o,
    output        wb_daq_slave_cyc_o,
    output        wb_daq_slave_stb_o,
    output  [2:0] wb_daq_slave_cti_o,
    output  [1:0] wb_daq_slave_bte_o,
    input  [31:0] wb_daq_slave_dat_i,
    input         wb_daq_slave_ack_i,
    input         wb_daq_slave_err_i,
    input         wb_daq_slave_rty_i,
    output [31:0] wb_ram0_adr_o,
    output [31:0] wb_ram0_dat_o,
    output  [3:0] wb_ram0_sel_o,
    output        wb_ram0_we_o,
    output        wb_ram0_cyc_o,
    output        wb_ram0_stb_o,
    output  [2:0] wb_ram0_cti_o,
    output  [1:0] wb_ram0_bte_o,
    input  [31:0] wb_ram0_dat_i,
    input         wb_ram0_ack_i,
    input         wb_ram0_err_i,
    input         wb_ram0_rty_i,
    output [31:0] wb_ram1_adr_o,
    output [31:0] wb_ram1_dat_o,
    output  [3:0] wb_ram1_sel_o,
    output        wb_ram1_we_o,
    output        wb_ram1_cyc_o,
    output        wb_ram1_stb_o,
    output  [2:0] wb_ram1_cti_o,
    output  [1:0] wb_ram1_bte_o,
    input  [31:0] wb_ram1_dat_i,
    input         wb_ram1_ack_i,
    input         wb_ram1_err_i,
    input         wb_ram1_rty_i,
    output [31:0] wb_ram2_adr_o,
    output [31:0] wb_ram2_dat_o,
    output  [3:0] wb_ram2_sel_o,
    output        wb_ram2_we_o,
    output        wb_ram2_cyc_o,
    output        wb_ram2_stb_o,
    output  [2:0] wb_ram2_cti_o,
    output  [1:0] wb_ram2_bte_o,
    input  [31:0] wb_ram2_dat_i,
    input         wb_ram2_ack_i,
    input         wb_ram2_err_i,
    input         wb_ram2_rty_i,
    output [31:0] wb_ram3_adr_o,
    output [31:0] wb_ram3_dat_o,
    output  [3:0] wb_ram3_sel_o,
    output        wb_ram3_we_o,
    output        wb_ram3_cyc_o,
    output        wb_ram3_stb_o,
    output  [2:0] wb_ram3_cti_o,
    output  [1:0] wb_ram3_bte_o,
    input  [31:0] wb_ram3_dat_i,
    input         wb_ram3_ack_i,
    input         wb_ram3_err_i,
    input         wb_ram3_rty_i);

wire [31:0] wb_m2s_cpu_master_ram0_adr;
wire [31:0] wb_m2s_cpu_master_ram0_dat;
wire  [3:0] wb_m2s_cpu_master_ram0_sel;
wire        wb_m2s_cpu_master_ram0_we;
wire        wb_m2s_cpu_master_ram0_cyc;
wire        wb_m2s_cpu_master_ram0_stb;
wire  [2:0] wb_m2s_cpu_master_ram0_cti;
wire  [1:0] wb_m2s_cpu_master_ram0_bte;
wire [31:0] wb_s2m_cpu_master_ram0_dat;
wire        wb_s2m_cpu_master_ram0_ack;
wire        wb_s2m_cpu_master_ram0_err;
wire        wb_s2m_cpu_master_ram0_rty;
wire [31:0] wb_m2s_cpu_master_ram1_adr;
wire [31:0] wb_m2s_cpu_master_ram1_dat;
wire  [3:0] wb_m2s_cpu_master_ram1_sel;
wire        wb_m2s_cpu_master_ram1_we;
wire        wb_m2s_cpu_master_ram1_cyc;
wire        wb_m2s_cpu_master_ram1_stb;
wire  [2:0] wb_m2s_cpu_master_ram1_cti;
wire  [1:0] wb_m2s_cpu_master_ram1_bte;
wire [31:0] wb_s2m_cpu_master_ram1_dat;
wire        wb_s2m_cpu_master_ram1_ack;
wire        wb_s2m_cpu_master_ram1_err;
wire        wb_s2m_cpu_master_ram1_rty;
wire [31:0] wb_m2s_cpu_master_ram2_adr;
wire [31:0] wb_m2s_cpu_master_ram2_dat;
wire  [3:0] wb_m2s_cpu_master_ram2_sel;
wire        wb_m2s_cpu_master_ram2_we;
wire        wb_m2s_cpu_master_ram2_cyc;
wire        wb_m2s_cpu_master_ram2_stb;
wire  [2:0] wb_m2s_cpu_master_ram2_cti;
wire  [1:0] wb_m2s_cpu_master_ram2_bte;
wire [31:0] wb_s2m_cpu_master_ram2_dat;
wire        wb_s2m_cpu_master_ram2_ack;
wire        wb_s2m_cpu_master_ram2_err;
wire        wb_s2m_cpu_master_ram2_rty;
wire [31:0] wb_m2s_cpu_master_ram3_adr;
wire [31:0] wb_m2s_cpu_master_ram3_dat;
wire  [3:0] wb_m2s_cpu_master_ram3_sel;
wire        wb_m2s_cpu_master_ram3_we;
wire        wb_m2s_cpu_master_ram3_cyc;
wire        wb_m2s_cpu_master_ram3_stb;
wire  [2:0] wb_m2s_cpu_master_ram3_cti;
wire  [1:0] wb_m2s_cpu_master_ram3_bte;
wire [31:0] wb_s2m_cpu_master_ram3_dat;
wire        wb_s2m_cpu_master_ram3_ack;
wire        wb_s2m_cpu_master_ram3_err;
wire        wb_s2m_cpu_master_ram3_rty;
wire [31:0] wb_m2s_cpu_master_dsp_slave_adr;
wire [31:0] wb_m2s_cpu_master_dsp_slave_dat;
wire  [3:0] wb_m2s_cpu_master_dsp_slave_sel;
wire        wb_m2s_cpu_master_dsp_slave_we;
wire        wb_m2s_cpu_master_dsp_slave_cyc;
wire        wb_m2s_cpu_master_dsp_slave_stb;
wire  [2:0] wb_m2s_cpu_master_dsp_slave_cti;
wire  [1:0] wb_m2s_cpu_master_dsp_slave_bte;
wire [31:0] wb_s2m_cpu_master_dsp_slave_dat;
wire        wb_s2m_cpu_master_dsp_slave_ack;
wire        wb_s2m_cpu_master_dsp_slave_err;
wire        wb_s2m_cpu_master_dsp_slave_rty;
wire [31:0] wb_m2s_cpu_master_daq_slave_adr;
wire [31:0] wb_m2s_cpu_master_daq_slave_dat;
wire  [3:0] wb_m2s_cpu_master_daq_slave_sel;
wire        wb_m2s_cpu_master_daq_slave_we;
wire        wb_m2s_cpu_master_daq_slave_cyc;
wire        wb_m2s_cpu_master_daq_slave_stb;
wire  [2:0] wb_m2s_cpu_master_daq_slave_cti;
wire  [1:0] wb_m2s_cpu_master_daq_slave_bte;
wire [31:0] wb_s2m_cpu_master_daq_slave_dat;
wire        wb_s2m_cpu_master_daq_slave_ack;
wire        wb_s2m_cpu_master_daq_slave_err;
wire        wb_s2m_cpu_master_daq_slave_rty;
wire [31:0] wb_m2s_daq_master_ram0_adr;
wire [31:0] wb_m2s_daq_master_ram0_dat;
wire  [3:0] wb_m2s_daq_master_ram0_sel;
wire        wb_m2s_daq_master_ram0_we;
wire        wb_m2s_daq_master_ram0_cyc;
wire        wb_m2s_daq_master_ram0_stb;
wire  [2:0] wb_m2s_daq_master_ram0_cti;
wire  [1:0] wb_m2s_daq_master_ram0_bte;
wire [31:0] wb_s2m_daq_master_ram0_dat;
wire        wb_s2m_daq_master_ram0_ack;
wire        wb_s2m_daq_master_ram0_err;
wire        wb_s2m_daq_master_ram0_rty;
wire [31:0] wb_m2s_daq_master_ram1_adr;
wire [31:0] wb_m2s_daq_master_ram1_dat;
wire  [3:0] wb_m2s_daq_master_ram1_sel;
wire        wb_m2s_daq_master_ram1_we;
wire        wb_m2s_daq_master_ram1_cyc;
wire        wb_m2s_daq_master_ram1_stb;
wire  [2:0] wb_m2s_daq_master_ram1_cti;
wire  [1:0] wb_m2s_daq_master_ram1_bte;
wire [31:0] wb_s2m_daq_master_ram1_dat;
wire        wb_s2m_daq_master_ram1_ack;
wire        wb_s2m_daq_master_ram1_err;
wire        wb_s2m_daq_master_ram1_rty;
wire [31:0] wb_m2s_daq_master_ram2_adr;
wire [31:0] wb_m2s_daq_master_ram2_dat;
wire  [3:0] wb_m2s_daq_master_ram2_sel;
wire        wb_m2s_daq_master_ram2_we;
wire        wb_m2s_daq_master_ram2_cyc;
wire        wb_m2s_daq_master_ram2_stb;
wire  [2:0] wb_m2s_daq_master_ram2_cti;
wire  [1:0] wb_m2s_daq_master_ram2_bte;
wire [31:0] wb_s2m_daq_master_ram2_dat;
wire        wb_s2m_daq_master_ram2_ack;
wire        wb_s2m_daq_master_ram2_err;
wire        wb_s2m_daq_master_ram2_rty;
wire [31:0] wb_m2s_daq_master_ram3_adr;
wire [31:0] wb_m2s_daq_master_ram3_dat;
wire  [3:0] wb_m2s_daq_master_ram3_sel;
wire        wb_m2s_daq_master_ram3_we;
wire        wb_m2s_daq_master_ram3_cyc;
wire        wb_m2s_daq_master_ram3_stb;
wire  [2:0] wb_m2s_daq_master_ram3_cti;
wire  [1:0] wb_m2s_daq_master_ram3_bte;
wire [31:0] wb_s2m_daq_master_ram3_dat;
wire        wb_s2m_daq_master_ram3_ack;
wire        wb_s2m_daq_master_ram3_err;
wire        wb_s2m_daq_master_ram3_rty;
wire [31:0] wb_m2s_daq_master_dsp_slave_adr;
wire [31:0] wb_m2s_daq_master_dsp_slave_dat;
wire  [3:0] wb_m2s_daq_master_dsp_slave_sel;
wire        wb_m2s_daq_master_dsp_slave_we;
wire        wb_m2s_daq_master_dsp_slave_cyc;
wire        wb_m2s_daq_master_dsp_slave_stb;
wire  [2:0] wb_m2s_daq_master_dsp_slave_cti;
wire  [1:0] wb_m2s_daq_master_dsp_slave_bte;
wire [31:0] wb_s2m_daq_master_dsp_slave_dat;
wire        wb_s2m_daq_master_dsp_slave_ack;
wire        wb_s2m_daq_master_dsp_slave_err;
wire        wb_s2m_daq_master_dsp_slave_rty;
wire [31:0] wb_m2s_daq_master_daq_slave_adr;
wire [31:0] wb_m2s_daq_master_daq_slave_dat;
wire  [3:0] wb_m2s_daq_master_daq_slave_sel;
wire        wb_m2s_daq_master_daq_slave_we;
wire        wb_m2s_daq_master_daq_slave_cyc;
wire        wb_m2s_daq_master_daq_slave_stb;
wire  [2:0] wb_m2s_daq_master_daq_slave_cti;
wire  [1:0] wb_m2s_daq_master_daq_slave_bte;
wire [31:0] wb_s2m_daq_master_daq_slave_dat;
wire        wb_s2m_daq_master_daq_slave_ack;
wire        wb_s2m_daq_master_daq_slave_err;
wire        wb_s2m_daq_master_daq_slave_rty;
wire [31:0] wb_m2s_dsp_master_ram0_adr;
wire [31:0] wb_m2s_dsp_master_ram0_dat;
wire  [3:0] wb_m2s_dsp_master_ram0_sel;
wire        wb_m2s_dsp_master_ram0_we;
wire        wb_m2s_dsp_master_ram0_cyc;
wire        wb_m2s_dsp_master_ram0_stb;
wire  [2:0] wb_m2s_dsp_master_ram0_cti;
wire  [1:0] wb_m2s_dsp_master_ram0_bte;
wire [31:0] wb_s2m_dsp_master_ram0_dat;
wire        wb_s2m_dsp_master_ram0_ack;
wire        wb_s2m_dsp_master_ram0_err;
wire        wb_s2m_dsp_master_ram0_rty;
wire [31:0] wb_m2s_dsp_master_ram1_adr;
wire [31:0] wb_m2s_dsp_master_ram1_dat;
wire  [3:0] wb_m2s_dsp_master_ram1_sel;
wire        wb_m2s_dsp_master_ram1_we;
wire        wb_m2s_dsp_master_ram1_cyc;
wire        wb_m2s_dsp_master_ram1_stb;
wire  [2:0] wb_m2s_dsp_master_ram1_cti;
wire  [1:0] wb_m2s_dsp_master_ram1_bte;
wire [31:0] wb_s2m_dsp_master_ram1_dat;
wire        wb_s2m_dsp_master_ram1_ack;
wire        wb_s2m_dsp_master_ram1_err;
wire        wb_s2m_dsp_master_ram1_rty;
wire [31:0] wb_m2s_dsp_master_ram2_adr;
wire [31:0] wb_m2s_dsp_master_ram2_dat;
wire  [3:0] wb_m2s_dsp_master_ram2_sel;
wire        wb_m2s_dsp_master_ram2_we;
wire        wb_m2s_dsp_master_ram2_cyc;
wire        wb_m2s_dsp_master_ram2_stb;
wire  [2:0] wb_m2s_dsp_master_ram2_cti;
wire  [1:0] wb_m2s_dsp_master_ram2_bte;
wire [31:0] wb_s2m_dsp_master_ram2_dat;
wire        wb_s2m_dsp_master_ram2_ack;
wire        wb_s2m_dsp_master_ram2_err;
wire        wb_s2m_dsp_master_ram2_rty;
wire [31:0] wb_m2s_dsp_master_ram3_adr;
wire [31:0] wb_m2s_dsp_master_ram3_dat;
wire  [3:0] wb_m2s_dsp_master_ram3_sel;
wire        wb_m2s_dsp_master_ram3_we;
wire        wb_m2s_dsp_master_ram3_cyc;
wire        wb_m2s_dsp_master_ram3_stb;
wire  [2:0] wb_m2s_dsp_master_ram3_cti;
wire  [1:0] wb_m2s_dsp_master_ram3_bte;
wire [31:0] wb_s2m_dsp_master_ram3_dat;
wire        wb_s2m_dsp_master_ram3_ack;
wire        wb_s2m_dsp_master_ram3_err;
wire        wb_s2m_dsp_master_ram3_rty;
wire [31:0] wb_m2s_dsp_master_dsp_slave_adr;
wire [31:0] wb_m2s_dsp_master_dsp_slave_dat;
wire  [3:0] wb_m2s_dsp_master_dsp_slave_sel;
wire        wb_m2s_dsp_master_dsp_slave_we;
wire        wb_m2s_dsp_master_dsp_slave_cyc;
wire        wb_m2s_dsp_master_dsp_slave_stb;
wire  [2:0] wb_m2s_dsp_master_dsp_slave_cti;
wire  [1:0] wb_m2s_dsp_master_dsp_slave_bte;
wire [31:0] wb_s2m_dsp_master_dsp_slave_dat;
wire        wb_s2m_dsp_master_dsp_slave_ack;
wire        wb_s2m_dsp_master_dsp_slave_err;
wire        wb_s2m_dsp_master_dsp_slave_rty;
wire [31:0] wb_m2s_dsp_master_daq_slave_adr;
wire [31:0] wb_m2s_dsp_master_daq_slave_dat;
wire  [3:0] wb_m2s_dsp_master_daq_slave_sel;
wire        wb_m2s_dsp_master_daq_slave_we;
wire        wb_m2s_dsp_master_daq_slave_cyc;
wire        wb_m2s_dsp_master_daq_slave_stb;
wire  [2:0] wb_m2s_dsp_master_daq_slave_cti;
wire  [1:0] wb_m2s_dsp_master_daq_slave_bte;
wire [31:0] wb_s2m_dsp_master_daq_slave_dat;
wire        wb_s2m_dsp_master_daq_slave_ack;
wire        wb_s2m_dsp_master_daq_slave_err;
wire        wb_s2m_dsp_master_daq_slave_rty;

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h90000000, 32'h90002000, 32'h90004000, 32'h90006000, 32'h70000000, 32'h80000000}),
    .MATCH_MASK ({32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hfffffc00, 32'hfffffc00}))
 wb_mux_cpu_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_cpu_master_adr_i),
    .wbm_dat_i (wb_cpu_master_dat_i),
    .wbm_sel_i (wb_cpu_master_sel_i),
    .wbm_we_i  (wb_cpu_master_we_i),
    .wbm_cyc_i (wb_cpu_master_cyc_i),
    .wbm_stb_i (wb_cpu_master_stb_i),
    .wbm_cti_i (wb_cpu_master_cti_i),
    .wbm_bte_i (wb_cpu_master_bte_i),
    .wbm_dat_o (wb_cpu_master_dat_o),
    .wbm_ack_o (wb_cpu_master_ack_o),
    .wbm_err_o (wb_cpu_master_err_o),
    .wbm_rty_o (wb_cpu_master_rty_o),
    .wbs_adr_o ({wb_m2s_cpu_master_ram0_adr, wb_m2s_cpu_master_ram1_adr, wb_m2s_cpu_master_ram2_adr, wb_m2s_cpu_master_ram3_adr, wb_m2s_cpu_master_dsp_slave_adr, wb_m2s_cpu_master_daq_slave_adr}),
    .wbs_dat_o ({wb_m2s_cpu_master_ram0_dat, wb_m2s_cpu_master_ram1_dat, wb_m2s_cpu_master_ram2_dat, wb_m2s_cpu_master_ram3_dat, wb_m2s_cpu_master_dsp_slave_dat, wb_m2s_cpu_master_daq_slave_dat}),
    .wbs_sel_o ({wb_m2s_cpu_master_ram0_sel, wb_m2s_cpu_master_ram1_sel, wb_m2s_cpu_master_ram2_sel, wb_m2s_cpu_master_ram3_sel, wb_m2s_cpu_master_dsp_slave_sel, wb_m2s_cpu_master_daq_slave_sel}),
    .wbs_we_o  ({wb_m2s_cpu_master_ram0_we, wb_m2s_cpu_master_ram1_we, wb_m2s_cpu_master_ram2_we, wb_m2s_cpu_master_ram3_we, wb_m2s_cpu_master_dsp_slave_we, wb_m2s_cpu_master_daq_slave_we}),
    .wbs_cyc_o ({wb_m2s_cpu_master_ram0_cyc, wb_m2s_cpu_master_ram1_cyc, wb_m2s_cpu_master_ram2_cyc, wb_m2s_cpu_master_ram3_cyc, wb_m2s_cpu_master_dsp_slave_cyc, wb_m2s_cpu_master_daq_slave_cyc}),
    .wbs_stb_o ({wb_m2s_cpu_master_ram0_stb, wb_m2s_cpu_master_ram1_stb, wb_m2s_cpu_master_ram2_stb, wb_m2s_cpu_master_ram3_stb, wb_m2s_cpu_master_dsp_slave_stb, wb_m2s_cpu_master_daq_slave_stb}),
    .wbs_cti_o ({wb_m2s_cpu_master_ram0_cti, wb_m2s_cpu_master_ram1_cti, wb_m2s_cpu_master_ram2_cti, wb_m2s_cpu_master_ram3_cti, wb_m2s_cpu_master_dsp_slave_cti, wb_m2s_cpu_master_daq_slave_cti}),
    .wbs_bte_o ({wb_m2s_cpu_master_ram0_bte, wb_m2s_cpu_master_ram1_bte, wb_m2s_cpu_master_ram2_bte, wb_m2s_cpu_master_ram3_bte, wb_m2s_cpu_master_dsp_slave_bte, wb_m2s_cpu_master_daq_slave_bte}),
    .wbs_dat_i ({wb_s2m_cpu_master_ram0_dat, wb_s2m_cpu_master_ram1_dat, wb_s2m_cpu_master_ram2_dat, wb_s2m_cpu_master_ram3_dat, wb_s2m_cpu_master_dsp_slave_dat, wb_s2m_cpu_master_daq_slave_dat}),
    .wbs_ack_i ({wb_s2m_cpu_master_ram0_ack, wb_s2m_cpu_master_ram1_ack, wb_s2m_cpu_master_ram2_ack, wb_s2m_cpu_master_ram3_ack, wb_s2m_cpu_master_dsp_slave_ack, wb_s2m_cpu_master_daq_slave_ack}),
    .wbs_err_i ({wb_s2m_cpu_master_ram0_err, wb_s2m_cpu_master_ram1_err, wb_s2m_cpu_master_ram2_err, wb_s2m_cpu_master_ram3_err, wb_s2m_cpu_master_dsp_slave_err, wb_s2m_cpu_master_daq_slave_err}),
    .wbs_rty_i ({wb_s2m_cpu_master_ram0_rty, wb_s2m_cpu_master_ram1_rty, wb_s2m_cpu_master_ram2_rty, wb_s2m_cpu_master_ram3_rty, wb_s2m_cpu_master_dsp_slave_rty, wb_s2m_cpu_master_daq_slave_rty}));

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h90000000, 32'h90002000, 32'h90004000, 32'h90006000, 32'h70000000, 32'h80000000}),
    .MATCH_MASK ({32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hfffffc00, 32'hfffffc00}))
 wb_mux_daq_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_daq_master_adr_i),
    .wbm_dat_i (wb_daq_master_dat_i),
    .wbm_sel_i (wb_daq_master_sel_i),
    .wbm_we_i  (wb_daq_master_we_i),
    .wbm_cyc_i (wb_daq_master_cyc_i),
    .wbm_stb_i (wb_daq_master_stb_i),
    .wbm_cti_i (wb_daq_master_cti_i),
    .wbm_bte_i (wb_daq_master_bte_i),
    .wbm_dat_o (wb_daq_master_dat_o),
    .wbm_ack_o (wb_daq_master_ack_o),
    .wbm_err_o (wb_daq_master_err_o),
    .wbm_rty_o (wb_daq_master_rty_o),
    .wbs_adr_o ({wb_m2s_daq_master_ram0_adr, wb_m2s_daq_master_ram1_adr, wb_m2s_daq_master_ram2_adr, wb_m2s_daq_master_ram3_adr, wb_m2s_daq_master_dsp_slave_adr, wb_m2s_daq_master_daq_slave_adr}),
    .wbs_dat_o ({wb_m2s_daq_master_ram0_dat, wb_m2s_daq_master_ram1_dat, wb_m2s_daq_master_ram2_dat, wb_m2s_daq_master_ram3_dat, wb_m2s_daq_master_dsp_slave_dat, wb_m2s_daq_master_daq_slave_dat}),
    .wbs_sel_o ({wb_m2s_daq_master_ram0_sel, wb_m2s_daq_master_ram1_sel, wb_m2s_daq_master_ram2_sel, wb_m2s_daq_master_ram3_sel, wb_m2s_daq_master_dsp_slave_sel, wb_m2s_daq_master_daq_slave_sel}),
    .wbs_we_o  ({wb_m2s_daq_master_ram0_we, wb_m2s_daq_master_ram1_we, wb_m2s_daq_master_ram2_we, wb_m2s_daq_master_ram3_we, wb_m2s_daq_master_dsp_slave_we, wb_m2s_daq_master_daq_slave_we}),
    .wbs_cyc_o ({wb_m2s_daq_master_ram0_cyc, wb_m2s_daq_master_ram1_cyc, wb_m2s_daq_master_ram2_cyc, wb_m2s_daq_master_ram3_cyc, wb_m2s_daq_master_dsp_slave_cyc, wb_m2s_daq_master_daq_slave_cyc}),
    .wbs_stb_o ({wb_m2s_daq_master_ram0_stb, wb_m2s_daq_master_ram1_stb, wb_m2s_daq_master_ram2_stb, wb_m2s_daq_master_ram3_stb, wb_m2s_daq_master_dsp_slave_stb, wb_m2s_daq_master_daq_slave_stb}),
    .wbs_cti_o ({wb_m2s_daq_master_ram0_cti, wb_m2s_daq_master_ram1_cti, wb_m2s_daq_master_ram2_cti, wb_m2s_daq_master_ram3_cti, wb_m2s_daq_master_dsp_slave_cti, wb_m2s_daq_master_daq_slave_cti}),
    .wbs_bte_o ({wb_m2s_daq_master_ram0_bte, wb_m2s_daq_master_ram1_bte, wb_m2s_daq_master_ram2_bte, wb_m2s_daq_master_ram3_bte, wb_m2s_daq_master_dsp_slave_bte, wb_m2s_daq_master_daq_slave_bte}),
    .wbs_dat_i ({wb_s2m_daq_master_ram0_dat, wb_s2m_daq_master_ram1_dat, wb_s2m_daq_master_ram2_dat, wb_s2m_daq_master_ram3_dat, wb_s2m_daq_master_dsp_slave_dat, wb_s2m_daq_master_daq_slave_dat}),
    .wbs_ack_i ({wb_s2m_daq_master_ram0_ack, wb_s2m_daq_master_ram1_ack, wb_s2m_daq_master_ram2_ack, wb_s2m_daq_master_ram3_ack, wb_s2m_daq_master_dsp_slave_ack, wb_s2m_daq_master_daq_slave_ack}),
    .wbs_err_i ({wb_s2m_daq_master_ram0_err, wb_s2m_daq_master_ram1_err, wb_s2m_daq_master_ram2_err, wb_s2m_daq_master_ram3_err, wb_s2m_daq_master_dsp_slave_err, wb_s2m_daq_master_daq_slave_err}),
    .wbs_rty_i ({wb_s2m_daq_master_ram0_rty, wb_s2m_daq_master_ram1_rty, wb_s2m_daq_master_ram2_rty, wb_s2m_daq_master_ram3_rty, wb_s2m_daq_master_dsp_slave_rty, wb_s2m_daq_master_daq_slave_rty}));

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h90000000, 32'h90002000, 32'h90004000, 32'h90006000, 32'h70000000, 32'h80000000}),
    .MATCH_MASK ({32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hffffe000, 32'hfffffc00, 32'hfffffc00}))
 wb_mux_dsp_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_dsp_master_adr_i),
    .wbm_dat_i (wb_dsp_master_dat_i),
    .wbm_sel_i (wb_dsp_master_sel_i),
    .wbm_we_i  (wb_dsp_master_we_i),
    .wbm_cyc_i (wb_dsp_master_cyc_i),
    .wbm_stb_i (wb_dsp_master_stb_i),
    .wbm_cti_i (wb_dsp_master_cti_i),
    .wbm_bte_i (wb_dsp_master_bte_i),
    .wbm_dat_o (wb_dsp_master_dat_o),
    .wbm_ack_o (wb_dsp_master_ack_o),
    .wbm_err_o (wb_dsp_master_err_o),
    .wbm_rty_o (wb_dsp_master_rty_o),
    .wbs_adr_o ({wb_m2s_dsp_master_ram0_adr, wb_m2s_dsp_master_ram1_adr, wb_m2s_dsp_master_ram2_adr, wb_m2s_dsp_master_ram3_adr, wb_m2s_dsp_master_dsp_slave_adr, wb_m2s_dsp_master_daq_slave_adr}),
    .wbs_dat_o ({wb_m2s_dsp_master_ram0_dat, wb_m2s_dsp_master_ram1_dat, wb_m2s_dsp_master_ram2_dat, wb_m2s_dsp_master_ram3_dat, wb_m2s_dsp_master_dsp_slave_dat, wb_m2s_dsp_master_daq_slave_dat}),
    .wbs_sel_o ({wb_m2s_dsp_master_ram0_sel, wb_m2s_dsp_master_ram1_sel, wb_m2s_dsp_master_ram2_sel, wb_m2s_dsp_master_ram3_sel, wb_m2s_dsp_master_dsp_slave_sel, wb_m2s_dsp_master_daq_slave_sel}),
    .wbs_we_o  ({wb_m2s_dsp_master_ram0_we, wb_m2s_dsp_master_ram1_we, wb_m2s_dsp_master_ram2_we, wb_m2s_dsp_master_ram3_we, wb_m2s_dsp_master_dsp_slave_we, wb_m2s_dsp_master_daq_slave_we}),
    .wbs_cyc_o ({wb_m2s_dsp_master_ram0_cyc, wb_m2s_dsp_master_ram1_cyc, wb_m2s_dsp_master_ram2_cyc, wb_m2s_dsp_master_ram3_cyc, wb_m2s_dsp_master_dsp_slave_cyc, wb_m2s_dsp_master_daq_slave_cyc}),
    .wbs_stb_o ({wb_m2s_dsp_master_ram0_stb, wb_m2s_dsp_master_ram1_stb, wb_m2s_dsp_master_ram2_stb, wb_m2s_dsp_master_ram3_stb, wb_m2s_dsp_master_dsp_slave_stb, wb_m2s_dsp_master_daq_slave_stb}),
    .wbs_cti_o ({wb_m2s_dsp_master_ram0_cti, wb_m2s_dsp_master_ram1_cti, wb_m2s_dsp_master_ram2_cti, wb_m2s_dsp_master_ram3_cti, wb_m2s_dsp_master_dsp_slave_cti, wb_m2s_dsp_master_daq_slave_cti}),
    .wbs_bte_o ({wb_m2s_dsp_master_ram0_bte, wb_m2s_dsp_master_ram1_bte, wb_m2s_dsp_master_ram2_bte, wb_m2s_dsp_master_ram3_bte, wb_m2s_dsp_master_dsp_slave_bte, wb_m2s_dsp_master_daq_slave_bte}),
    .wbs_dat_i ({wb_s2m_dsp_master_ram0_dat, wb_s2m_dsp_master_ram1_dat, wb_s2m_dsp_master_ram2_dat, wb_s2m_dsp_master_ram3_dat, wb_s2m_dsp_master_dsp_slave_dat, wb_s2m_dsp_master_daq_slave_dat}),
    .wbs_ack_i ({wb_s2m_dsp_master_ram0_ack, wb_s2m_dsp_master_ram1_ack, wb_s2m_dsp_master_ram2_ack, wb_s2m_dsp_master_ram3_ack, wb_s2m_dsp_master_dsp_slave_ack, wb_s2m_dsp_master_daq_slave_ack}),
    .wbs_err_i ({wb_s2m_dsp_master_ram0_err, wb_s2m_dsp_master_ram1_err, wb_s2m_dsp_master_ram2_err, wb_s2m_dsp_master_ram3_err, wb_s2m_dsp_master_dsp_slave_err, wb_s2m_dsp_master_daq_slave_err}),
    .wbs_rty_i ({wb_s2m_dsp_master_ram0_rty, wb_s2m_dsp_master_ram1_rty, wb_s2m_dsp_master_ram2_rty, wb_s2m_dsp_master_ram3_rty, wb_s2m_dsp_master_dsp_slave_rty, wb_s2m_dsp_master_daq_slave_rty}));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_dsp_slave
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_dsp_slave_adr, wb_m2s_daq_master_dsp_slave_adr, wb_m2s_dsp_master_dsp_slave_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_dsp_slave_dat, wb_m2s_daq_master_dsp_slave_dat, wb_m2s_dsp_master_dsp_slave_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_dsp_slave_sel, wb_m2s_daq_master_dsp_slave_sel, wb_m2s_dsp_master_dsp_slave_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_dsp_slave_we, wb_m2s_daq_master_dsp_slave_we, wb_m2s_dsp_master_dsp_slave_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_dsp_slave_cyc, wb_m2s_daq_master_dsp_slave_cyc, wb_m2s_dsp_master_dsp_slave_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_dsp_slave_stb, wb_m2s_daq_master_dsp_slave_stb, wb_m2s_dsp_master_dsp_slave_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_dsp_slave_cti, wb_m2s_daq_master_dsp_slave_cti, wb_m2s_dsp_master_dsp_slave_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_dsp_slave_bte, wb_m2s_daq_master_dsp_slave_bte, wb_m2s_dsp_master_dsp_slave_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_dsp_slave_dat, wb_s2m_daq_master_dsp_slave_dat, wb_s2m_dsp_master_dsp_slave_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_dsp_slave_ack, wb_s2m_daq_master_dsp_slave_ack, wb_s2m_dsp_master_dsp_slave_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_dsp_slave_err, wb_s2m_daq_master_dsp_slave_err, wb_s2m_dsp_master_dsp_slave_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_dsp_slave_rty, wb_s2m_daq_master_dsp_slave_rty, wb_s2m_dsp_master_dsp_slave_rty}),
    .wbs_adr_o (wb_dsp_slave_adr_o),
    .wbs_dat_o (wb_dsp_slave_dat_o),
    .wbs_sel_o (wb_dsp_slave_sel_o),
    .wbs_we_o  (wb_dsp_slave_we_o),
    .wbs_cyc_o (wb_dsp_slave_cyc_o),
    .wbs_stb_o (wb_dsp_slave_stb_o),
    .wbs_cti_o (wb_dsp_slave_cti_o),
    .wbs_bte_o (wb_dsp_slave_bte_o),
    .wbs_dat_i (wb_dsp_slave_dat_i),
    .wbs_ack_i (wb_dsp_slave_ack_i),
    .wbs_err_i (wb_dsp_slave_err_i),
    .wbs_rty_i (wb_dsp_slave_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_daq_slave
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_daq_slave_adr, wb_m2s_daq_master_daq_slave_adr, wb_m2s_dsp_master_daq_slave_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_daq_slave_dat, wb_m2s_daq_master_daq_slave_dat, wb_m2s_dsp_master_daq_slave_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_daq_slave_sel, wb_m2s_daq_master_daq_slave_sel, wb_m2s_dsp_master_daq_slave_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_daq_slave_we, wb_m2s_daq_master_daq_slave_we, wb_m2s_dsp_master_daq_slave_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_daq_slave_cyc, wb_m2s_daq_master_daq_slave_cyc, wb_m2s_dsp_master_daq_slave_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_daq_slave_stb, wb_m2s_daq_master_daq_slave_stb, wb_m2s_dsp_master_daq_slave_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_daq_slave_cti, wb_m2s_daq_master_daq_slave_cti, wb_m2s_dsp_master_daq_slave_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_daq_slave_bte, wb_m2s_daq_master_daq_slave_bte, wb_m2s_dsp_master_daq_slave_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_daq_slave_dat, wb_s2m_daq_master_daq_slave_dat, wb_s2m_dsp_master_daq_slave_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_daq_slave_ack, wb_s2m_daq_master_daq_slave_ack, wb_s2m_dsp_master_daq_slave_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_daq_slave_err, wb_s2m_daq_master_daq_slave_err, wb_s2m_dsp_master_daq_slave_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_daq_slave_rty, wb_s2m_daq_master_daq_slave_rty, wb_s2m_dsp_master_daq_slave_rty}),
    .wbs_adr_o (wb_daq_slave_adr_o),
    .wbs_dat_o (wb_daq_slave_dat_o),
    .wbs_sel_o (wb_daq_slave_sel_o),
    .wbs_we_o  (wb_daq_slave_we_o),
    .wbs_cyc_o (wb_daq_slave_cyc_o),
    .wbs_stb_o (wb_daq_slave_stb_o),
    .wbs_cti_o (wb_daq_slave_cti_o),
    .wbs_bte_o (wb_daq_slave_bte_o),
    .wbs_dat_i (wb_daq_slave_dat_i),
    .wbs_ack_i (wb_daq_slave_ack_i),
    .wbs_err_i (wb_daq_slave_err_i),
    .wbs_rty_i (wb_daq_slave_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_ram0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_ram0_adr, wb_m2s_daq_master_ram0_adr, wb_m2s_dsp_master_ram0_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_ram0_dat, wb_m2s_daq_master_ram0_dat, wb_m2s_dsp_master_ram0_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_ram0_sel, wb_m2s_daq_master_ram0_sel, wb_m2s_dsp_master_ram0_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_ram0_we, wb_m2s_daq_master_ram0_we, wb_m2s_dsp_master_ram0_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_ram0_cyc, wb_m2s_daq_master_ram0_cyc, wb_m2s_dsp_master_ram0_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_ram0_stb, wb_m2s_daq_master_ram0_stb, wb_m2s_dsp_master_ram0_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_ram0_cti, wb_m2s_daq_master_ram0_cti, wb_m2s_dsp_master_ram0_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_ram0_bte, wb_m2s_daq_master_ram0_bte, wb_m2s_dsp_master_ram0_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_ram0_dat, wb_s2m_daq_master_ram0_dat, wb_s2m_dsp_master_ram0_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_ram0_ack, wb_s2m_daq_master_ram0_ack, wb_s2m_dsp_master_ram0_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_ram0_err, wb_s2m_daq_master_ram0_err, wb_s2m_dsp_master_ram0_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_ram0_rty, wb_s2m_daq_master_ram0_rty, wb_s2m_dsp_master_ram0_rty}),
    .wbs_adr_o (wb_ram0_adr_o),
    .wbs_dat_o (wb_ram0_dat_o),
    .wbs_sel_o (wb_ram0_sel_o),
    .wbs_we_o  (wb_ram0_we_o),
    .wbs_cyc_o (wb_ram0_cyc_o),
    .wbs_stb_o (wb_ram0_stb_o),
    .wbs_cti_o (wb_ram0_cti_o),
    .wbs_bte_o (wb_ram0_bte_o),
    .wbs_dat_i (wb_ram0_dat_i),
    .wbs_ack_i (wb_ram0_ack_i),
    .wbs_err_i (wb_ram0_err_i),
    .wbs_rty_i (wb_ram0_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_ram1
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_ram1_adr, wb_m2s_daq_master_ram1_adr, wb_m2s_dsp_master_ram1_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_ram1_dat, wb_m2s_daq_master_ram1_dat, wb_m2s_dsp_master_ram1_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_ram1_sel, wb_m2s_daq_master_ram1_sel, wb_m2s_dsp_master_ram1_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_ram1_we, wb_m2s_daq_master_ram1_we, wb_m2s_dsp_master_ram1_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_ram1_cyc, wb_m2s_daq_master_ram1_cyc, wb_m2s_dsp_master_ram1_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_ram1_stb, wb_m2s_daq_master_ram1_stb, wb_m2s_dsp_master_ram1_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_ram1_cti, wb_m2s_daq_master_ram1_cti, wb_m2s_dsp_master_ram1_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_ram1_bte, wb_m2s_daq_master_ram1_bte, wb_m2s_dsp_master_ram1_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_ram1_dat, wb_s2m_daq_master_ram1_dat, wb_s2m_dsp_master_ram1_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_ram1_ack, wb_s2m_daq_master_ram1_ack, wb_s2m_dsp_master_ram1_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_ram1_err, wb_s2m_daq_master_ram1_err, wb_s2m_dsp_master_ram1_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_ram1_rty, wb_s2m_daq_master_ram1_rty, wb_s2m_dsp_master_ram1_rty}),
    .wbs_adr_o (wb_ram1_adr_o),
    .wbs_dat_o (wb_ram1_dat_o),
    .wbs_sel_o (wb_ram1_sel_o),
    .wbs_we_o  (wb_ram1_we_o),
    .wbs_cyc_o (wb_ram1_cyc_o),
    .wbs_stb_o (wb_ram1_stb_o),
    .wbs_cti_o (wb_ram1_cti_o),
    .wbs_bte_o (wb_ram1_bte_o),
    .wbs_dat_i (wb_ram1_dat_i),
    .wbs_ack_i (wb_ram1_ack_i),
    .wbs_err_i (wb_ram1_err_i),
    .wbs_rty_i (wb_ram1_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_ram2
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_ram2_adr, wb_m2s_daq_master_ram2_adr, wb_m2s_dsp_master_ram2_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_ram2_dat, wb_m2s_daq_master_ram2_dat, wb_m2s_dsp_master_ram2_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_ram2_sel, wb_m2s_daq_master_ram2_sel, wb_m2s_dsp_master_ram2_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_ram2_we, wb_m2s_daq_master_ram2_we, wb_m2s_dsp_master_ram2_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_ram2_cyc, wb_m2s_daq_master_ram2_cyc, wb_m2s_dsp_master_ram2_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_ram2_stb, wb_m2s_daq_master_ram2_stb, wb_m2s_dsp_master_ram2_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_ram2_cti, wb_m2s_daq_master_ram2_cti, wb_m2s_dsp_master_ram2_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_ram2_bte, wb_m2s_daq_master_ram2_bte, wb_m2s_dsp_master_ram2_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_ram2_dat, wb_s2m_daq_master_ram2_dat, wb_s2m_dsp_master_ram2_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_ram2_ack, wb_s2m_daq_master_ram2_ack, wb_s2m_dsp_master_ram2_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_ram2_err, wb_s2m_daq_master_ram2_err, wb_s2m_dsp_master_ram2_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_ram2_rty, wb_s2m_daq_master_ram2_rty, wb_s2m_dsp_master_ram2_rty}),
    .wbs_adr_o (wb_ram2_adr_o),
    .wbs_dat_o (wb_ram2_dat_o),
    .wbs_sel_o (wb_ram2_sel_o),
    .wbs_we_o  (wb_ram2_we_o),
    .wbs_cyc_o (wb_ram2_cyc_o),
    .wbs_stb_o (wb_ram2_stb_o),
    .wbs_cti_o (wb_ram2_cti_o),
    .wbs_bte_o (wb_ram2_bte_o),
    .wbs_dat_i (wb_ram2_dat_i),
    .wbs_ack_i (wb_ram2_ack_i),
    .wbs_err_i (wb_ram2_err_i),
    .wbs_rty_i (wb_ram2_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_ram3
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_cpu_master_ram3_adr, wb_m2s_daq_master_ram3_adr, wb_m2s_dsp_master_ram3_adr}),
    .wbm_dat_i ({wb_m2s_cpu_master_ram3_dat, wb_m2s_daq_master_ram3_dat, wb_m2s_dsp_master_ram3_dat}),
    .wbm_sel_i ({wb_m2s_cpu_master_ram3_sel, wb_m2s_daq_master_ram3_sel, wb_m2s_dsp_master_ram3_sel}),
    .wbm_we_i  ({wb_m2s_cpu_master_ram3_we, wb_m2s_daq_master_ram3_we, wb_m2s_dsp_master_ram3_we}),
    .wbm_cyc_i ({wb_m2s_cpu_master_ram3_cyc, wb_m2s_daq_master_ram3_cyc, wb_m2s_dsp_master_ram3_cyc}),
    .wbm_stb_i ({wb_m2s_cpu_master_ram3_stb, wb_m2s_daq_master_ram3_stb, wb_m2s_dsp_master_ram3_stb}),
    .wbm_cti_i ({wb_m2s_cpu_master_ram3_cti, wb_m2s_daq_master_ram3_cti, wb_m2s_dsp_master_ram3_cti}),
    .wbm_bte_i ({wb_m2s_cpu_master_ram3_bte, wb_m2s_daq_master_ram3_bte, wb_m2s_dsp_master_ram3_bte}),
    .wbm_dat_o ({wb_s2m_cpu_master_ram3_dat, wb_s2m_daq_master_ram3_dat, wb_s2m_dsp_master_ram3_dat}),
    .wbm_ack_o ({wb_s2m_cpu_master_ram3_ack, wb_s2m_daq_master_ram3_ack, wb_s2m_dsp_master_ram3_ack}),
    .wbm_err_o ({wb_s2m_cpu_master_ram3_err, wb_s2m_daq_master_ram3_err, wb_s2m_dsp_master_ram3_err}),
    .wbm_rty_o ({wb_s2m_cpu_master_ram3_rty, wb_s2m_daq_master_ram3_rty, wb_s2m_dsp_master_ram3_rty}),
    .wbs_adr_o (wb_ram3_adr_o),
    .wbs_dat_o (wb_ram3_dat_o),
    .wbs_sel_o (wb_ram3_sel_o),
    .wbs_we_o  (wb_ram3_we_o),
    .wbs_cyc_o (wb_ram3_cyc_o),
    .wbs_stb_o (wb_ram3_stb_o),
    .wbs_cti_o (wb_ram3_cti_o),
    .wbs_bte_o (wb_ram3_bte_o),
    .wbs_dat_i (wb_ram3_dat_i),
    .wbs_ack_i (wb_ram3_ack_i),
    .wbs_err_i (wb_ram3_err_i),
    .wbs_rty_i (wb_ram3_rty_i));

endmodule