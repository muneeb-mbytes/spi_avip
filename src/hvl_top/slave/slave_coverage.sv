`ifndef SLAVE_COVERAGE_INCLUDED_
`define SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_coverage
// slave_coverage determines the how much code is covered for better functionality of the TB.
//--------------------------------------------------------------------------------------------
class slave_coverage extends uvm_subscriber;
  `uvm_component_utils(slave_coverage)

  //creating handle for slave transaction coverage

  slave_tx slave_tx_cov_data;


  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments 
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup slave_covergroup with function sample (slave_agent_config cfg, slave_tx packet);
    option.per_instance = 1;

    // Mode of the operation
    OPERATION_MODE : coverpoint operation_modes_e'(cfg.spi_mode) {
      option.comment = "Operation mode SPI. CPOL and CPHA";
      // TODO(mshariff): 
      // bins
      // bins cpol0_cpha0 = {0};
      // bins cpol0_cpha1 = {1};
      // bins cpol1_cpha0 = {2};
      // bins cpol1_cpha1 = {3};
    }

    // Chip-selcet to first SCLK-edge delay
    C2T_DELAY : coverpoint cfg.c2tdelay {
      option.comment = "Delay betwen CS assertion to first SCLK edge";
      // TODO(mshariff): 
      // bins DELAY[] = {[1:3]};
      // bins DELAY_4_to_10 = {[4:10]};
    }
      // illegal_bins illegal_bin = {0};
      // Chip-selcet to first SCLK-edge delay 
      //T2C_DELAY : coverpoint cfg.t2cdelay {
      // option.comment = "Delay betwen last SCLK to the CS assertion";
      // TODO(mshariff): 
      // bins delay[] ={[11:13]};
      // }
    
    SHIFT_DIRECTION : coverpoint shift_direction_e'(cfg.spi_mode) {
      option.comment = "Shift direction SPI. MSB and LSB";
      bins lsb_first = {[0]};
      bins msb_first = {[1]};
      bins lsb_first = {[1]};
      bins msb_first = {[0]};
    } 
    CS : coverpoint packet.cs{
      option.comment = "Chip select assign one slave based on config"; 
      bins cs = {[0]};
      bins cs = {[1]};
    }
    NO_OF_SLAVES : coverpoint cfg.no_of_slaves {
      option.comment = "no of the slaves selected based on the config";
      // bins slave_1 = {[1]};
      // bins slave_2 = {[1]};
      // bins slave_3 = {[1]};
      // bins slave_4 = {[1]};
      // illegal_bins illegal_bin = {0};
    }
    
    DATA_WIDTH : coverpoint packet.data_width {
      option.comment = "Data of a perticular width is transfered";
      bins dw[] : {[0:$]};
    }
    // TODO(mshariff): 
    // Have illegal bins 
    // illegal_bins illegal_bin = {0};
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
      bins mosi_hit = {1};
      // illegal_bins illegal bin that if data is not of the multiple of the 8 then illegal bin 
    }
    master_in_slave_out : coverpoint (miso.packet {
      option.comment = "the mosi data goes from master to slave";
      bins miso_hit = {1};
      //  illegal_bins illegal bin that if data is not of the multiple of the 8 then illegal bin
    }
  
    //illegal bin : coverpoint 


    //CROSS OF THE CFG AND THE PACKET WITH MULTIPLE COVERPOINT.
   
    //Cross of the OPERATION_MODE with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
    OPERATION_MODE X CS = cross OPERATION_MODE,CS;
    OPERATION_MODE X DATA_WIDTH = cross RATION_MODE,DATA_WIDTH;
    OPERATION_MODE X master_out_slave_in = cross OPERATION_MODE,master_out_slave_in;
    OPERATION_MODE X master_in_slave_out = cross OPERATION_MODE,master_in_slave_out;

    //Cross of the C2T_DELAY with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
    C2T_DELAY x CS = cross C2T_DELAY,CS;
    C2T_DELAY x DATA_WIDTH = cross C2T_DELAY,DATA_WIDTH;
    C2T_DELAY x master_out_slave_in = cross C2T_DELAY,master_out_slave_in;
    C2T_DELAY x master_in_slave_out = cross C2T_DELAY,master_in_slave_out;

    //Cross of the T2C_DELAY with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
    //T2C_DELAY x CS = cross T2C_DELAY,CS;
    //T2C_DELAY x DATA_WIDTH = cross T2C_DELAY,DATA_WIDTH;
    //T2C_DELAY x master_out_slave_in = cross T2C_DELAY,master_out_slave_in;
    //T2C_DELAY x master_in_slave_out = cross T2C_DELAY,master_in_slave_out;

    //Cross of the SHIFT_DIRECTION with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
        
    SHIFT_DIRECTION x CS = cross SHIFT_DIRECTION,CS;
    SHIFT_DIRECTION x DATA_WIDTH = cross SHIFT_DIRECTION,DATA_WIDTH;
    SHIFT_DIRECTION x master_out_slave_in = cross SHIFT_DIRECTION,master_out_slave_in;
    SHIFT_DIRECTION x master_in_slave_out = cross SHIFT_DIRECTION,master_in_slave_out;

    //Cross of the NO_OF_SLAVES with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
    NO_OF_SLAVES x CS = cross NO_OF_SLAVES,CS;
    NO_OF_SLAVES x DATA_WIDTH = cross NO_OF_SLAVES,DATA_WIDTH;
    NO_OF_SLAVES x master_out_slave_in = cross NO_OF_SLAVES,master_out_slave_in;
    NO_OF_SLAVES x master_in_slave_out = cross NO_OF_SLAVES,master_in_slave_out;



  endgroup : slave_covergroup

  // Variable: slave_cg
  // Handle for slave covergroup
  slave_coverage slave_cg;

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
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(slave_tx slave_tx_h)
  extern virtual function report_phase(uvm_phase phase);

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
  // slave_cg = new(); 
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
function void slave_coverage::write(slave_tx slave_tx_cov_data)
  // TODO(mshariff): 
  // cg.sample(slave_agent_cfg_h, slave_tx_cov_data);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function slave_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformat("Slave Agent Coverage = %0.2f %%",
                                       slave_cg.get_inst_coverage()), UVM_NONE);
endfunction: report_phase
`endif

