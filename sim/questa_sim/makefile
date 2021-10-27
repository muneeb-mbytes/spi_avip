# -s means silent mode
# The command executed along with the output will be displayed on the terminal
# To get only the ouput use 'silent' mode
#
# make target -s


# -n or --just-print 
# The first test I perform on a new makefile target is to invoke make with the --just-print (-n) option. 
# This causes make to read the makefile and print every command it would normally execute to 
# update the target but without executing them.
#
# make target -n


# When you run make with the -i or --ignore-errors flag, 
# errors are ignored in all recipes of all rules. 
# A rule in the makefile for the special target .IGNORE has the same effect, 
# if there are no prerequisites. This is less flexible but sometimes useful.
# When errors are to be ignored, because of -i flag, make treats an error return just like success,
# except that it prints out a message that tells you the status code the shell exited with, 
# and says that the error has been ignored.
#
# make target -i 

.IGNORE:
	compile
	simulate

# WE can also use the target where we WANT the silent mode 
.SILENT:
	compile
	simulate
	usage

# First target will be executed incase the user doesn't mention
# the target to execute
# In this case, usage will be executed
# Usage
usage:
	echo "";
	echo "-----------------------------------------------------------------";
	echo "------------------------- Usage ---------------------------------";
	echo "";
	echo "make target <options> <variable>=<value>";
	echo "";
	echo "To compile use:"
	echo "make compile";
	echo "";
	echo "To simulate use:"
	echo "make simulate test=<test_name>";
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-----------------------------------------------------------------";
	echo "";

all:
	make clean; make compile; make simulate;

# TODO(mshariff): 
# Need some work to point to the 
# dir:
# 	mkdir -p logfiles_and_waveforms

# For Assertions use +acc options
compile:
	make clean_compile;
	vlib work; 
	vlog -sv \
	+acc \
	-l spi_compile.log \
	-f ../spi_compile.f

	# -s means silent mode
	#  The command executed along with the output will be displayed on the terminal
	#  To get only the ouput use 'silent' mode
	# make compile_war_err -s
	# or use .SILENT
	make compile_war_err

# Setting a default test as base_test
ifndef test
override test = base_test
endif

simulate:
	make clean_simulate
	mkdir $(test)

	# Use -novopt for no optimization - Makes the simulation slower
	vsim -vopt \
	work.hvl_top \
	work.hdl_top \
	-voptargs=+acc=npr \
	-assertdebug \
	+UVM_TESTNAME=$(test) \
	-l $(test)/$(test).log \
	-c -do "log -r /*; add wave -r /*; run -all;" \
	-wlf $(test)/waveform.wlf

	make simulate_war_err

	# To open the waveform use the below command 
	# vsim -view waveform.wlf &

clean_simulate:
	rm -rf *_test

clean_compile:
	rm -rf work/ *_compile.log transcript waveform.wlf

clean:
	make clean_compile
	make clean_simulate

compile_war_err:
	echo "";
	echo "-----------------------------------------------------------------";
	echo "------------------- Compilation Report --------------------------";
	echo "";
	grep "^** " spi_compile.log;
	echo "";
	grep "^Error" spi_compile.log;
	echo "";
	echo "Log file path: spi_compile.log"
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-----------------------------------------------------------------";
	echo "";

simulate_war_err:
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-------------------- Simulation Report --------------------------";
	echo "";
	echo "Simulator Errors";
	grep "Error" $(test)/$(test).log;
	echo "";
	echo "UVM Fatal";
	grep "UVM_FATAL" $(test)/$(test).log;
	echo "";
	echo "UVM Errors";
	grep "UVM_ERROR" $(test)/$(test).log;
	echo "";
	echo "UVM Warnings";
	grep "UVM_WARNING" $(test)/$(test).log;
	echo "";
	echo "Testname: $(test)"
	echo "Log file path: $(test)/$(test).log"
	echo "Waveform: vsim -view $(test)/waveform.wlf &"
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-----------------------------------------------------------------";
	echo "";
