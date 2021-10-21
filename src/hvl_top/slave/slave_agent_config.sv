`ifndef SLAVE_AGENT_CONFIG_INCLUDED_
`define SLAVE_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_agent_config
<<<<<<< HEAD
// Used as the configuration class for slave agent and it's components
=======
// <Description_here>
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
//--------------------------------------------------------------------------------------------
class slave_agent_config extends uvm_object;
  `uvm_object_utils(slave_agent_config)

<<<<<<< HEAD
  // Variable: vif
  // Virtual handle for spi interface
  virtual spi_if vif;

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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

