`ifndef SLAVE_AGENT_CONFIG_INCLUDED_
`define SLAVE_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_agent_config
// Used as the configuration class for slave agent and it's components
//--------------------------------------------------------------------------------------------
class slave_agent_config extends uvm_object;
  `uvm_object_utils(slave_agent_config)

  // Variable: vif
  // Virtual handle for spi interface
  virtual spi_if vif;

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent_config");
endclass : slave_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_agent_config
//--------------------------------------------------------------------------------------------
function slave_agent_config::new(string name = "slave_agent_config");
  super.new(name);
endfunction : new

`endif

