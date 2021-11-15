`ifndef MASTER_COVERAGE_INCLUDED_
`define MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_coverage
// master_coverage determines the how much code is covered for better functionality of the TB.
//--------------------------------------------------------------------------------------------
class master_coverage extends uvm_subscriber#(master_tx);
  `uvm_component_utils(master_coverage)

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  master_agent_config master_agent_cfg_h;

  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup master_covergroup with function sample (master_agent_config cfg, master_tx packet);
    option.per_instance = 1;

    // Mode of the operation

    OPERATION_MODE : coverpoint {cpol,cpha} operation_modes_e'(cfg.spi_mode) {
      option.comment = "Operation mode SPI. CPOL and CPHA";
      // TODO(mshariff): 
      {cpol,cpha} = operation_modes_e'(cfg.spi_mode);
      bins cpol_cpha[] = [0:3];
      // bins cpol0_cpha0 = 0;
      // bins cpol0_cpha1 = 1;
      // bins cpol1_cpha0 = 2;
      // bins cpol1_cpha1 = 3;
    }

    // Chip-selcet to first SCLK-edge delay
    C2T_DELAY : coverpoint cfg.c2tdelay {
      option.comment = "Delay betwen CS assertion to first SCLK edge";
      // TODO(mshariff): 
      // bins DELAY_1 = 1;
      // bins DELAY_2 = 2;
      // bins DELAY_3 = 3;
      // bins DELAY_4_to_10 = [4:10];
    }
      // illegal_bins illegal_bin = 0;
      // Chip-selcet to first SCLK-edge delay 
    T2C_DELAY : coverpoint cfg.t2cdelay {
      option.comment = "Delay betwen last SCLK to the CS assertion";
      // TODO(mshariff): 
      // bins delay_11 = 11;
      // bins delay_12 = 12;
      // bins delay_13 = 13;
    }
    
    SHIFT_DIRECTION : coverpoint shift_direction_e'(cfg.spi_mode) {
      option.comment = "Shift direction SPI. MSB and LSB";
      direction = shift_direction_e'(cfg.spi_mode); 
      bins lsb_first = 0;
      bins msb_first = 1;
    } 
    
    CS : coverpoint packet.cs(NO_OF_SLAVES-1){
      option.comment = "Chip select assign one slave based on config"; 
      bins cs_0 = 0;
      bins cs_1 = 1;
      bins cs_2 = 2;
      bins cs_3 = 3;
    }
    //NO_OF_SLAVES : coverpoint cfg.no_of_slaves {
     // option.comment = "no of the slaves selected based on the config";
      // bins slave_1 = 1;
      // bins slave_2 = 1;
      // bins slave_3 = 1;
      // bins slave_4 = 1;
      // illegal_bins illegal_bin = 0;
    }
    
    DATA_WIDTH : coverpoint packet.data_width {
      option.comment = "Data of particular width is transfered";
      bins dw_8b[] : [0:7];
      bins dw_16b[] : [8:15];
      bins dw_32b[] : [16:31];
      bins dw_64b[] : [32:63];
      bins dw_128b[] : [64:128];
  
    BAUD_RATE : coverpoint cfg.baudrate {
      option.comment = "it control the rate of transfer in communication channel";
      bins baudrate = 2; 
      // need to add bins for baud rate 

    }
    
    // TODO(mshariff): 
    // Have illegal bins 
    // illegal_bins illegal_bin = 0;
    // Have ignore bins
    // ignore_bins ignore_bin = 
    // Have coverpoints for cfg and packet
    //
    //cfg : coverpoint cfg{
    //option.comment = "  
    // Have interesting cross coverpoints between cfg and packet
    // cfg X packet : cross cfg X packet;
      
        
    master_out_slave_in : coverpoint (mosi.packet {
      option.comment = "the mosi data goes from master to slave";
      bins mosi_hit = 1;
      // illegal_bins illegal bin that if data is not of the multiple of the 8 then illegal bin 
    }
    master_in_slave_out : coverpoint (miso.packet {
      option.comment = "the mosi data goes from master to slave";
      bins miso_hit = 1;
      //  illegal_bins illegal bin that if data is not of the multiple of the 8 then illegal bin
    }
  
    //illegal bin : coverpoint
    
    //CROSS OF THE CFG AND THE PACKET WITH MULTIPLE COVERPOINT.
//--------------------------------------------------------------------------------------------
// 1. 
//--------------------------------------------------------------------------------------------
 //   //CROSS OF THE CFG AND THE PACKET WITH MULTIPLE COVERPOINT.
 //  
 //   //Cross of the OPERATION_MODE with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
 //   OPERATION_MODE X CS = cross OPERATION_MODE,CS;
 //   OPERATION_MODE X DATA_WIDTH = cross RATION_MODE,DATA_WIDTH;
 //   OPERATION_MODE X master_out_slave_in = cross OPERATION_MODE,master_out_slave_in;
 //   OPERATION_MODE X master_in_slave_out = cross OPERATION_MODE,master_in_slave_out;

 //   //Cross of the C2T_DELAY with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
 //   C2T_DELAY x CS = cross C2T_DELAY,CS;
 //   C2T_DELAY x DATA_WIDTH = cross C2T_DELAY,DATA_WIDTH;
 //   C2T_DELAY x master_out_slave_in = cross C2T_DELAY,master_out_slave_in;
 //   C2T_DELAY x master_in_slave_out = cross C2T_DELAY,master_in_slave_out;

 //   //Cross of the T2C_DELAY with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
 //   T2C_DELAY x CS = cross T2C_DELAY,CS;
 //   T2C_DELAY x DATA_WIDTH = cross T2C_DELAY,DATA_WIDTH;
 //   T2C_DELAY x master_out_slave_in = cross T2C_DELAY,master_out_slave_in;
 //   T2C_DELAY x master_in_slave_out = cross T2C_DELAY,master_in_slave_out;

 //   //Cross of the SHIFT_DIRECTION with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
 //       
 //   SHIFT_DIRECTION x CS = cross SHIFT_DIRECTION,CS;
 //   SHIFT_DIRECTION x DATA_WIDTH = cross SHIFT_DIRECTION,DATA_WIDTH;
 //   SHIFT_DIRECTION x master_out_slave_in = cross SHIFT_DIRECTION,master_out_slave_in;
 //   SHIFT_DIRECTION x master_in_slave_out = cross SHIFT_DIRECTION,master_in_slave_out;

 //   //Cross of the NO_OF_SLAVES with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
 //   NO_OF_SLAVES x CS = cross NO_OF_SLAVES,CS;
 //   NO_OF_SLAVES x DATA_WIDTH = cross NO_OF_SLAVES,DATA_WIDTH;
 //   NO_OF_SLAVES x master_out_slave_in = cross NO_OF_SLAVES,master_out_slave_in;
 //   NO_OF_SLAVES x master_in_slave_out = cross NO_OF_SLAVES,master_in_slave_out;

 // 
 // 
 // endgroup : master_covergroup

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

