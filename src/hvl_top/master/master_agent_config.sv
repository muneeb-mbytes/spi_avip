`ifndef MASTER_AGENT_CONFIG_INCLUDED_
`define MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent_config
// Used as the configuration class for master agent, for configuring number of slaves and number
// of active passive agents to be created
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

  // Variable: wdelay
  // Delay between the transfers 
  // Used for setting the time required between 2 transfers 
  // in terms of SCLK 
  // Default value is 1
  int wdelay = 1;
  
  // Variable: primary_prescalar
  // Used for setting the primary prescalar value for baudrate
  bit[2:0] primary_prescalar;

  // Variable: secondary_prescalar
  // Used for setting the secondary prescalar value for baudrate
  bit[2:0] secondary_prescalar;

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent_config");
  extern function void do_print(uvm_printer printer);
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

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void master_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);


  printer.print_field ("is_active",is_active,1, UVM_DEC);
  printer.print_field ("no_of_slaves",no_of_slaves,$bits(no_of_slaves), UVM_DEC);
  printer.print_field ("spi_mode",spi_mode, 2, UVM_ENUM);
  printer.print_field ("shift_dir",shift_dir, 1, UVM_ENUM);
  printer.print_field ("c2tdelay",c2tdelay, $bits(c2tdelay), UVM_DEC);
  printer.print_field ("t2cdelay",t2cdelay, $bits(t2cdelay), UVM_DEC);
  printer.print_field ("wdelay",wdelay, $bits(wdelay), UVM_DEC);
  printer.print_field ("primary_prescalar",primary_prescalar, 3, UVM_DEC);
  printer.print_field ("secondary_prescalar",secondary_prescalar, 3, UVM_HEX);
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  
endfunction : do_print

`endif

