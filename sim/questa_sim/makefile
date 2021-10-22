all:
	make clean; make compile; make simulate; make clean;

compile:
	vlib work; 
	vlog -sv \
	-l spi_compile.log \
	+incdir+../../src/globals/ \
	+incdir+../../src/hvl_top/master/ \
	+incdir+../../src/hdl_top/master_agent_bfm/  \
	+incdir+../../src/hvl_top/env/virtual_sequencer/ \
  +incdir+../../src/hvl_top/test/virtual_sequence/ \
	+incdir+../../src/hvl_top/env \
	+incdir+../../src/hvl_top/slave \
	+incdir+../../src/hvl_top/test \
	+incdir+../../src/hdl_top/slave_agent_bfm \
	+incdir+../../src/hdl_top/spi_interface \
	../../src/globals/spi_globals_pkg.sv \
	../../src/hvl_top/master/spi_master_pkg.sv \
	../../src/hvl_top/slave/spi_slave_pkg.sv \
	../../src/hvl_top/env/spi_env_pkg.sv \
	../../src/hvl_top/test/test_pkg.sv \
	../../src/hdl_top/spi_interface/spi_if.sv \
	../../src/hdl_top/slave_agent_bfm/slave_driver_bfm.sv \
	../../src/hdl_top/slave_agent_bfm/slave_monitor_bfm.sv \
	../../src/hdl_top/slave_agent_bfm/slave_agent_bfm.sv \
	../../src/hdl_top/hdl_top.sv \
	../../src/hvl_top/hvl_top.sv 

# TODO 
# Add the master HDL files when done
simulate:
	vsim -novopt work.hvl_top work.hdl_top -l spi_simulate.log -c -do "log -r /*; add wave -r /*; run -all;" \
	-wlf waveform.wlf
	# To open the waveform use the below command 
	# vsim -view waveform.wlf &

clean:
	rm -rf work/ transcript waveform.wlf
