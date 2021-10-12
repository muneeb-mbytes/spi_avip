`ifndef ENV_CONFIG_INCLUDED_
`define ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env_config
// Description of the class.
//--------------------------------------------------------------------------------------------
class env_config extends uvm_object;
  //register with factory so that we can use create uvm method
  //and override in future if necessary
  `uvm_object_utils(env_config)

 // bit has_scoreboard=1;
  bit has_m_agt=1;
//  bit has_s_agt=1;
  bit has_mtop=1;
//  bit has_stop=1;

  bit has_virtual_sequencer=1;
  master_agent_config  m_cfg[]; 
 // slave_agent_config  s_cfg[];

  int no_of_magent=1;
 // int no_of_sagent=1;
  int no_of_mtop=1;
 // int no_of_stop=1;
 // int no_of_sb=1;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env_config");
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

`endif

