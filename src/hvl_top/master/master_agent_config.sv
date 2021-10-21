`ifndef MASTER_AGENT_CONFIG_INCLUDED_
`define MASTER_AGENT_CONFIG_INCLUDED_
<<<<<<< HEAD
// TODO(mshariff): 
//--------------------------------------------------------------------------------------------
// Class: master_agent_config
// Used as the configuration class for master agent and it's components
=======

//--------------------------------------------------------------------------------------------
// Class: master_agent_config
// <Description_here>
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
//--------------------------------------------------------------------------------------------
class master_agent_config extends uvm_object;
  `uvm_object_utils(master_agent_config)

<<<<<<< HEAD
  // Variable: vif
  // Virtual handle for spi interface
  virtual spi_if vif;

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

=======
  uvm_active_passive_enum is_active=UVM_ACTIVE; 
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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

