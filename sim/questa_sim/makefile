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
	echo "make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>";
	echo "";
	echo "Example:":
	echo "make simulate test=base_test uvm_verbosity=UVM_HIGH";
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
	+cover \
	+fcover \
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

# Setting the default uvm_verbosity to UVM_MEDIUM
ifndef uvm_verbosity
override uvm_verbosity = UVM_MEDIUM
endif

## For randomized seed
# TODO(mshariff): 
#Add this line after -sva 
#-sv_seed random 

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
	+UVM_VERBOSITY=$(uvm_verbosity) \
	-l $(test)/$(test).log \
	-sva \
  -coverage \
	-c -do "log -r /*; add wave -r /*; coverage save -onexit -assert -directive -cvg -codeAll $(test)/coverage.ucdb; run -all; exit" \
	-wlf $(test)/waveform.wlf

	# For checking and reporting simulation errors
	make simulate_war_err

	## TODO(mshariff): 
	## # For coverage report in text format 
	## #vcover report -text $(test)/$(test)_cov
	# -c -do "log -r /*; add wave -r /*; coverage save -onexit -assert -directive -cvg -codeAll $(test)/coverage.ucdb; coverage report -file $(teset)/coverage.txt -byfile -detail -noannotate -option -directive -cvg -details -verbose; run -all; exit" \
	# vcover report -file  -byfile -detail -noannotate -option -cvg

	# For coverage report in HTML format 
	vcover report -html $(test)/coverage.ucdb -htmldir $(test)/html_cov_report

	# To open the html coverage report
	# firefox test_folder/html_cov_report/index.html &

	# To open the waveform use the below command 
	# vsim -view waveform.wlf &
	#
	# To open the wavefrom with saved signals
	# vsim -view waveform.wlf -do spi_waves.do &

clean_simulate:
	rm -rf *_test

clean_compile:
	rm -rf work/ *_compile.log transcript waveform.wlf

clean:
	make clean_compile
	make clean_simulate

##
## For Regression and coverage merge
##
##clean:
##	rm -rf modelsim.* transcript* *log* work vsim.wlf fcover* covhtml* mem_cov*
##	clear
##report:
##	vcover merge mem_cover mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8
##	vcover report -html mem_cover
##
##regress: clean run_test1_single run_test2_wrap run_test3_single run_test4_wrap run_test5_single run_test6_single run_test7_wrap run_test8_wrap report html
##


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
