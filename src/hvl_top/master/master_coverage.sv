`ifndef MASTER_COVERAGE_INCLUDED_
`define MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_coverage
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_coverage extends uvm_subscriber#(master_tx);
  `uvm_component_utils(master_coverage)

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  master_agent_config master_agent_cfg_h;

  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments
  //-------------------------------------------------------
  covergroup master_covergroup with function sample (master_agent_config cfg, master_tx packet);
    option.per_instance = 1;

    // Mode of the operation
    OPERATION_MODE : coverpoint operation_modes_e'(cfg.spi_mode) {
      option.comment = "Operation mode SPI. CPOL and CPHA";
      // TODO(mshariff): 
      // bins 
    }

    // Chip-selcet to first SCLK-edge delay
    C2T_DELAY : coverpoint cfg.c2tdelay {
      option.comment = "Delay betwen CS assertion to first SCLK edge";
      // TODO(mshariff): 
      // bins DELAY[] = {[1:3]};
      // bins DELAY_4_to_10 = {[4:10]};
    }

    // TODO(mshariff): 
    // Have illegal bins 
    // Have ignore bins
    // Have coverpoints for cfg and packet
    // Have interesting cross coverpoints between cfg and packet
  endgroup : master_covergroup

  // Variable: master_cg
  // Handle for master covergroup
  master_coverage master_cg;

  // TODO(mshariff):
  //
  // Example for reference 
  //
	// MSHA: coverpoint mode {
	// MSHA: 	// Manually create a separate bin for each value
	// MSHA: 	bins zero = {0};
	// MSHA: 	bins one  = {1};
	// MSHA: 	
	// MSHA: 	// Allow SystemVerilog to automatically create separate bins for each value
	// MSHA: 	// Values from 0 to maximum possible value is split into separate bins
	// MSHA: 	bins range[] = {[0:$]};
	// MSHA: 	
	// MSHA: 	// Create automatic bins for both the given ranges
	// MSHA: 	bins c[] = { [2:3], [5:7]};
	// MSHA: 	
	// MSHA: 	// Use fixed number of automatic bins. Entire range is broken up into 4 bins
	// MSHA: 	bins range[4] = {[0:$]};
	// MSHA: 	
	// MSHA: 	// If the number of bins cannot be equally divided for the given range, then 
	// MSHA: 	// the last bin will include remaining items; Here there are 13 values to be
	// MSHA: 	// distributed into 4 bins which yields:
	// MSHA: 	// [1,2,3] [4,5,6] [7,8,9] [10, 1, 3, 6]
	// MSHA: 	bins range[4] = {[1:10], 1, 3, 6};
	// MSHA: 	
	// MSHA: 	// A single bin to store all other values that don't belong to any other bin
	// MSHA: 	bins others = default;
	// MSHA: }

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_coverage", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(master_tx master_tx_h)
  extern virtual function report_phase(uvm_phase phase);

endclass : master_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_coverage::new(string name = "master_coverage", uvm_component parent = null);
  super.new(name, parent);
  // TODO(mshariff): Create the covergroup
  // master_cg = new(); 
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void master_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "master_coverage");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase
*/

//--------------------------------------------------------------------------------------------
// Function: write
// // TODO(mshariff): Add comments
//--------------------------------------------------------------------------------------------
function void master_coverage::write(master_tx master_tx_cov_data)
  // TODO(mshariff): 
  // cg.sample(master_agent_cfg_h, master_tx_cov_data);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function master_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformat("Master Agent Coverage = %0.2f %%",
                                       master_cg.get_inst_coverage()), UVM_NONE);
endfunction: report_phase
`endif

