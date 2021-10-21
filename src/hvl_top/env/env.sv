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
  slave_agent slave_agent_h[];
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

  `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);

  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg_h)) begin
   `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the slave_agent_config from config_db"))
  end

  ma_h=master_agent::type_id::create("master_agent",this);

  slave_agent_h = new[e_cfg_h.no_of_slaves];
  foreach(slave_agent_h[i]) begin
    slave_agent_h[i] = slave_agent::type_id::create($sformatf("slave_agent_h[%0d]",i),this);
  end

  if(e_cfg_h.has_virtual_sqr) begin
    m_v_sqr_h = master_virtual_sequencer::type_id::create("master_virtual_sequencer",this);
    s_v_sqr_h = slave_virtual_sequencer::type_id::create("slave_virtual_sequencer",this);
  end


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

