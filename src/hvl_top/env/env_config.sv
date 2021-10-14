`include "slave_agent_config.sv"

`ifdef _ENV_CONFIG_INCLUDED_
`define _ENV_CONFIG_INCLUDED_

//-----------------------------------------------------------------------------
//Class:env_config
//Description of the class
//----------------------------------------------------------------------------

class env_config extends uvm_object;

// register with factory so that we can use create uvm method
// and override in future if necessary
  `uvm_object_utils(env_config)

  slave_agent_config sa_cfg;
//----------------------------------------------------------------------------
//Externally defined tasks and functions
//---------------------------------------------------------------------------

extern function new(string name="env_config");

endclass:env_config

//--------------------------------------------------------------------------
//Constructor:new
//Initializes the class object
//parametrs:
//name- instance name of the master_template
//-------------------------------------------------------------------------

function env_config::new(string name="env_config");
  super.new(name);
endfunction:new

`endif

