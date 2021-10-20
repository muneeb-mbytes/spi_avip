
all:
	make clean; make compile; make simulate

compile:
	vlib work; vlog -sv top.sv

simulate:
	vsim -novopt work.tb2 -c -do "log -r /*; add wave -r /*; run -all;" +UVM_TESTNAME=spi_fd_8b_test -wlf waveform.wlf

clean:
	rm -rf work/ transcript vsim.wlf
