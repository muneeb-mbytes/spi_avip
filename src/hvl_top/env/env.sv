`ifndef ENV_INCLUDED_
`define ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env
// Description:
// Environment contains slave_agent_top and slave_virtual_sequencer
//--------------------------------------------------------------------------------------------
class env extends uvm_env;

  //-------------------------------------------------------
  // Factory registration to create uvm_method and override it
  //-------------------------------------------------------
  `uvm_component_utils(env)
  
  env_config e_cfg_h;
  //-------------------------------------------------------
  // declaring master handles
  //-------------------------------------------------------
  master_agent ma_h;
  master_virtual_sequencer m_v_sqr_h;
  
  //-------------------------------------------------------
  // Declaring slave handles
  //-------------------------------------------------------
  slave_agent sa_h;
  slave_virtual_sequencer s_v_sqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function env::new(string name = "env",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description:
//  Create required components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);
<<<<<<< HEAD

  `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);

=======
  `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  ma_h=master_agent::type_id::create("master_agent",this);
  m_v_sqr_h = master_virtual_sequencer::type_id::create("master_virtual_sequencer",this);
  s_v_sqr_h = slave_virtual_sequencer::type_id::create("slave_virtual_sequencer",this);
  sa_h = slave_agent::type_id::create("slave_agent",this);
<<<<<<< HEAD

=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description:
//  To connect driver and sequencer
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

`endif

