all:
	make clean; make compile; make simulate

compile:
	vlib work; vlog -sv env/env.sv env/env_config.sv env/virtual_sequence.sv

simulate:
	#vsim -novopt work.ram_tb -do runcmds.do
	vsim -novopt work.ram_tb -c -do "log -r /*; add wave -r /*; run -all;" -wlf waveform.wlf

clean:
	rm -rf work/ transcript vsim.wlf
