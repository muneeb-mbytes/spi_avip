`ifndef ENV_CONFIG_INCLUDED_
`define ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env_config
// This class is used as configuration class for environment and its components
//--------------------------------------------------------------------------------------------
class env_config extends uvm_object;
  `uvm_object_utils(env_config)
  
  //int no_of_magent = 1;
  //int no_of_sagent = 1;

  // Variable: has_scoreboard
  // Enables the scoreboard. Default value is 1
  bit has_scoreboard = 1;

  // Variable: has_virtual_sqr
  // Enables the virtual sequencer. Default value is 1
  bit has_virtual_seqr = 1;

  // Variable: no_of_slaves
  // Number of slaves connected to the SPI interface
  int no_of_slaves;

  // Variable: master_agent_cfg_h
  // Handle for master agent configuration
  master_agent_config master_agent_cfg_h;

  // Variable: slave_agent_cfg_h
  // Dynamic array of slave agnet configuration handles
  slave_agent_config slave_agent_cfg_h[];

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "env_config");
  extern function void do_print(uvm_printer printer);

endclass : env_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env_config
//--------------------------------------------------------------------------------------------
function env_config::new(string name = "env_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void env_config::do_print(uvm_printer printer);
  super.do_print(printer);
  
  printer.print_field ("has_scoreboard",has_scoreboard,1, UVM_DEC);
  printer.print_field ("has_virtual_sqr",has_virtual_seqr,1, UVM_DEC);
  printer.print_field ("no_of_slaves",no_of_slaves,$bits(no_of_slaves), UVM_HEX);

  //commenting the lines because printing master and slave configuration in respective master
  //agent and slave agent classes

  //printer.print_field ("ma_cfg_h",ma_cfg_h,1,UVM_HEX);
  //foreach(sa_cfg_h[i])
  //printer.print_field($sformatf("sa_cfg_h[%0d]",i),this.sa_cfg_h[i],8,UVM_HEX);
endfunction : do_print

`endif

