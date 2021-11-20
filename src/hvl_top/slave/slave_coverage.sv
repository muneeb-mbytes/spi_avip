`ifndef SLAVE_COVERAGE_INCLUDED_
`define SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_coverage
// slave_coverage determines the how much code is covered for better functionality of the TB.
//--------------------------------------------------------------------------------------------
class slave_coverage extends uvm_subscriber#(slave_tx);
  `uvm_component_utils(slave_coverage)

  //creating handle for slave transaction coverage
  slave_tx slave_tx_cov_data;

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments 
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup slave_covergroup with function sample (slave_agent_config cfg, slave_tx packet);
  option.per_instance = 1;

    // Mode of the operation
    OPERATION_MODE_CP : coverpoint operation_modes_e'(cfg.spi_mode) {
      option.comment = "Operation mode SPI. CPOL and CPHA";
      
      bins MODE[] = {[0:3]};
    }
 
    
    SHIFT_DIRECTION_CP : coverpoint shift_direction_e'(cfg.shift_dir) {
      option.comment = "Shift direction SPI. MSB and LSB";
      bins LSB_FIRST = {0};
      bins MSB_FIRST = {1};    
    }

     MOSI_DATA_TRANSFER_CP : coverpoint packet.master_out_slave_in.size()*CHAR_LENGTH {
      option.comment = "different data size of the packets transfer";
      bins TRANSFER_8BIT = {8};
      bins TRANSFER_16BIT = {16};
      bins TRANSFER_24BIT = {24};
      bins TRANSFER_32BIT = {32};
      bins TRANSFER_64BIT = {64};
      bins TRANSFER_MANY_BITS = {[72:MAXIMUM_BITS]};
    }  
      MISO_DATA_TRANSFER_CP : coverpoint packet.master_in_slave_out.size()*CHAR_LENGTH {
      option.comment = "different data size of the packets transfer";
      bins TRANSFER_8BIT = {8};
      bins TRANSFER_16BIT = {16};
      bins TRANSFER_24BIT = {24};
      bins TRANSFER_32BIT = {32};
      bins TRANSFER_64BIT = {64};
      bins TRANSFER_MANY_BITS = {[72:MAXIMUM_BITS]};
    } 


//    // TODO(mshariff): 
//    // Have illegal bins 
//    // illegal_bins illegal_bin = {0};
//    // Have ignore bins
//    // ignore_bins ignore_bin = 
//    // Have coverpoints for cfg and packet
//    //
//    //cfg : coverpoint cfg{
//    //option.comment = "  
//    // Have interesting cross coverpoints between cfg and packet
//    // cfg X packet : cross cfg X packet;
//    
//    //--------------------------------------------------------------------------------------------
//    // 
//    //--------------------------------------------------------------------------------------------
//   
     // Cross of the OPERATION_MODE with mosi and miso data 
     OPERATION_MODE_X_MASTER_OUT_SLAVE_IN : cross OPERATION_MODE_CP,MOSI_DATA_TRANSFER_CP;
     OPERATION_MODE_X_MASTER_IN_SLAVE_OUT : cross OPERATION_MODE_CP,MISO_DATA_TRANSFER_CP;

     // Cross of the SHIFT_DIRECTION with mosi and miso data 
     SHIFT_DIRECTION_X_MASTER_OUT_SLAVE_IN : cross SHIFT_DIRECTION_CP,MOSI_DATA_TRANSFER_CP;
     SHIFT_DIRECTION_X_MASTER_IN_SLAVE_OUT : cross SHIFT_DIRECTION_CP,MISO_DATA_TRANSFER_CP;
//
//    // Cross of the SHIFT_DIRECTION with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
//        
//    //SHIFT_DIRECTION x CS = cross SHIFT_DIRECTION,CS;
//    // SHIFT_DIRECTION x DATA_WIDTH = cross SHIFT_DIRECTION,DATA_WIDTH;
//    // SHIFT_DIRECTION x master_out_slave_in = cross SHIFT_DIRECTION,master_out_slave_in;
//    //SHIFT_DIRECTION x master_in_slave_out = cross SHIFT_DIRECTION,master_in_slave_out;
//
//    // Cross of the NO_OF_SLAVES with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
//    //NO_OF_SLAVES x CS = cross NO_OF_SLAVES,CS;
//    //NO_OF_SLAVES x DATA_WIDTH = cross NO_OF_SLAVES,DATA_WIDTH;
//    // NO_OF_SLAVES x master_out_slave_in = cross NO_OF_SLAVES,master_out_slave_in;
//    // NO_OF_SLAVES x master_in_slave_out = cross NO_OF_SLAVES,master_in_slave_out;
//
//
//
  
  endgroup :slave_covergroup
  // Variable: slave_cg
  // Handle for slave covergroup
  //slave_coverage slave_cg;

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
  extern function new(string name = "slave_coverage", uvm_component parent = null);
  //extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(slave_tx t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : slave_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_coverage::new(string name = "slave_coverage", uvm_component parent = null);
  super.new(name, parent);
  // TODO(mshariff): Create the covergroup
   slave_covergroup = new(); 
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void slave_coverage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_coverage::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task slave_coverage::run_phase(uvm_phase phase);

  phase.raise_objection(this, "slave_coverage");

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
function void slave_coverage::write(slave_tx t);
  // TODO(mshariff): 
  // cg.sample(slave_agent_cfg_h, slave_tx_cov_data);     
    slave_covergroup.sample(slave_agent_cfg_h,t);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void slave_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Slave Agent Coverage = %0.2f %%",
                                       slave_covergroup.get_coverage()), UVM_NONE);
endfunction: report_phase
`endif

