`ifndef MASTER_AGENT_CONFIG_INCLUDED_
`define MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent_config
// Used as the configuration class for master agent and it's components
//--------------------------------------------------------------------------------------------
class master_agent_config extends uvm_object;
  `uvm_object_utils(master_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to 
  // this master over SPI interface
  int no_of_slaves;

  // Variable: spi_mode 
  // Used for setting the opeartion mode 
  operation_modes_e spi_mode;

  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  shift_direction_e shift_dir;

  // Variable: c2tdelay
  // Delay between CS assertion to clock generation
  // Used for setting the setup time 
  // Default value is 1
  int c2tdelay = 1;

  // Variable: t2cdelay
  // Delay between end of clock to CS de-assertion
  // Used for setting the hold time 
  // Default value is 1
  int t2cdelay = 1;

  // Variable: primary_prescalar
  // Used for setting the primary prescalar value for baudrate
  bit[2:0] primary_prescalar;

  // Variable: secondary_prescalar
  // Used for setting the secondary prescalar value for baudrate
  bit[2:0] secondary_prescalar;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent_config");
endclass : master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_agent_config
//--------------------------------------------------------------------------------------------
function master_agent_config::new(string name = "master_agent_config");
  super.new(name);
endfunction : new

`endif

