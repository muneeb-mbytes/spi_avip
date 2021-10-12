all:
	make clean; make compile; make simulate

compile:
#	vlib work; vlog -sv +incdir+../master +incdir+../test ../test/test_pkg.sv ../env/top.sv
	vlib work; vlog -sv  ../env/top.sv

simulate:
	#vsim -novopt work.ram_tb -do runcmds.do
	vsim -novopt work.hvl_top -c -do "log -r /*; add wave -r /*; run -all;" -wlf waveform.wlf

clean:
	rm -rf work/ transcript vsim.wlf
