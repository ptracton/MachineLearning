#exec make TARGET=${1} CPU=${2} clean
#exec make TARGET=${1} CPU=${2}

vlib work


vlog ${1}.v +incdir+../testbench +incdir+../simulation  +incdir+../testbench

vlog ../rtl/top.v +incdir+../simulation +incdir+../rtl/bus_matrix/ +incdir+../testbench
vlog ../rtl/cpu/cpu_top.v
vlog ../rtl/syscon/syscon.v +define+SIM
vlog ../rtl/daq/daq_slave.v
vlog ../rtl/daq/daq_top.v
vlog ../rtl/daq/daq_sm.v
vlog ../rtl/dsp/dsp_slave.v
vlog ../rtl/dsp/dsp_top.v
vlog ../rtl/wb_master_interface/arbiter.v
vlog ../rtl/wb_master_interface/wb_master_interface.v +incdir+../behavioral/wb_common/
vlog ../rtl/bus_matrix/bus_matrix.v +incdir+../behavioral/wb_common/

vlog ../behavioral/wb_ram/wb_ram.v +incdir+../behavioral/wb_common/
vlog ../behavioral/wb_ram/wb_ram_generic.v


vlog ../behavioral/wb_intercon/wb_arbiter.v  +incdir+../behavioral/
vlog ../behavioral/wb_intercon/wb_data_resize.v
vlog ../behavioral/wb_intercon/wb_mux.v  +incdir+../behavioral/

vlog ../testbench/testbench.v +incdir+../simulation
vlog ../testbench/test_tasks.v +incdir+../simulation
vlog ../testbench/dsp_tasks.v +incdir+../simulation  +incdir+../testbench
vlog ../testbench/dump.v

vlog ../simulation/basic_00.v +incdir+../simulation  +incdir+../testbench


vsim -voptargs=+acc work.testbench  +define+RTL +define+SIM

do wave.do
run -all
