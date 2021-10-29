`ifndef SLAVE_AGENT_CONFIG_INCLUDED_
`define SLAVE_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_agent_config
//  Used as the configuration class for slave agent and it's components
//--------------------------------------------------------------------------------------------
class slave_agent_config extends uvm_object;
  
  `uvm_object_utils(slave_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: slave_id
  // Used for indicating the ID of this slave
  int slave_id;

  // Variable: spi_mode 
  // Used for setting the opeartion mode 
  operation_modes_e spi_mode;

  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  shift_direction_e shift_dir;

  // Variable: has_coverage
  // Used for enabling the slave agent coverage
  bit has_coverage;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent_config");
  extern function void do_print(uvm_printer printer);
endclass : slave_agent_config

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - slave_agent_config
//--------------------------------------------------------------------------------------------
function slave_agent_config::new(string name = "slave_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);

//printer.print_field("is_active",is_active);
  printer.print_field ("is_active",is_active,1, UVM_DEC);
  printer.print_field ("slave_id",slave_id,2, UVM_DEC);
  printer.print_field ("spi_mode",spi_mode, 2, UVM_ENUM);
  printer.print_field ("shift_dir",shift_dir, 1, UVM_ENUM);
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  
endfunction : do_print

`endif

