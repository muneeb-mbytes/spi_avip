ll:
		make clean; make compile; make simulate; make clean;

compile:
		vlib work; 
			vlog -sv \
					+incdir+../src/hvl_top/master/ \
					+incdir+../src/hvl_top/env/virtual_sequencer/ \
				  +incdir+../src/hvl_top/test/virtual_sequence/ \
			  	+incdir+../src/hvl_top/env \
					+incdir+../src/hvl_top/slave \
					+incdir+../src/hvl_top/test \
					../src/hvl_top/master/spi_master_pkg.sv \
					../src/hvl_top/slave/spi_slave_pkg.sv \
					../src/hvl_top/env/spi_env_pkg.sv \
					../src/hvl_top/test/test_pkg.sv \
					../src/hdl_top/spi_if.sv \
			  	../src/hvl_top/hvl_top.sv 
				

simulate:
		vsim -novopt work.hvl_top -c -do "log -r /*; add wave -r /*; run -all;" \
				-wlf waveform.wlf
			# To open the waveform use the below command 
			# 	# vsim -view waveform.wlf &
			#
clean:
	rm -rf work/ transcript waveform.wlf
