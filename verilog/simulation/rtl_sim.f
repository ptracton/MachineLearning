      +incdir+../testbench
      +incdir+../simulation
      +incdir+../rtl
      +incdir+../behavioral/wb_intercon
      +incdir+../behavioral/
      +incdir+../behavioral/wb_common/
      +incdir+../rtl/bus_matrix/
      +define+VERBOSE
      +define+SIM

      ../rtl/top.v
      ../rtl/cpu/cpu_top.v
      ../rtl/syscon/syscon.v
      ../rtl/daq/daq_slave.v
      ../rtl/daq/daq_top.v
      ../rtl/daq/daq_sm.v
      ../rtl/dsp/dsp_slave.v
      ../rtl/dsp/dsp_top.v
      ../rtl/dsp/dsp_sm.v
      ../rtl/dsp/dsp_equations_top.v
      ../rtl/dsp/dsp_equation_sum.v
      ../rtl/dsp/dsp_equation_multiply.v
      ../rtl/dsp/dsp_equation_dtree.v

      ../rtl/wb_master_interface/arbiter.v
      ../rtl/wb_master_interface/wb_master_interface.v
      ../rtl/bus_matrix/bus_matrix.v

      ../behavioral/wb_ram/wb_ram.v
      ../behavioral/wb_ram/wb_ram_generic.v


      ../behavioral/wb_intercon/wb_arbiter.v
      ../behavioral/wb_intercon/wb_data_resize.v
      ../behavioral/wb_intercon/wb_mux.v

      //      ../behavioral/wb_common/wb_common.v
      //      ../behavioral/wb_common/wb_common_params.v

      ../testbench/testbench.v
      ../testbench/test_tasks.v
      ../testbench/dsp_tasks.v
      ../testbench/dump.v
