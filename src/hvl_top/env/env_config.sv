`ifndef ENV_CONFIG_INCLUDED_
`define ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env_config
// <Description_here>
//--------------------------------------------------------------------------------------------
class env_config extends uvm_object;
  `uvm_object_utils(env_config)
<<<<<<< HEAD
  
  int no_of_sagent = 1;

  slave_agent_config sa_cfg_h;
=======
  int no_of_magent = 1;
  int no_of_sagent = 1;

  master_agent_config ma_cfg_h[];
  slave_agent_config sa_cfg_h[];
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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

