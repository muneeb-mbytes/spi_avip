`ifndef ENV_INCLUDED_
`define ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env
// Description:
// Environment contains slave_agent_top,master_agent_top and virtual_sequencer
//--------------------------------------------------------------------------------------------
class env extends uvm_env;
  `uvm_component_utils(env)
  
  // Variable: env_cfg_h
  // Declaring environment configuration handle
  env_config env_cfg_h;
  
  // Variable: scoreboard_h
  // declaring scoreboard handle
  spi_scoreboard scoreboard_h;
  
  // Variable: virtual_seqr_h
  // declaring handle for virtual sequencer
  virtual_sequencer virtual_seqr_h;
  
  // Variable: slave_agent_h
  // Declaring slave handles
  slave_agent slave_agent_h[];

  // Variable: master_agent_h
  // declaring master agent handle
  master_agent master_agent_h;

  
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
// name - env
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function env::new(string name = "env",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description:
// Create required components
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);

  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h)) begin
   `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the slave_agent_config from config_db"))
  end

  master_agent_h=master_agent::type_id::create("master_agent_h",this);

  slave_agent_h = new[env_cfg_h.no_of_slaves];
  foreach(slave_agent_h[i]) begin
    slave_agent_h[i] = slave_agent::type_id::create($sformatf("slave_agent_h[%0d]",i),this);
  end

  if(env_cfg_h.has_virtual_seqr) begin
    virtual_seqr_h = virtual_sequencer::type_id::create("virtual_seqr_h",this);
  end

  if(env_cfg_h.has_scoreboard) begin
    scoreboard_h = spi_scoreboard::type_id::create("scoreboard_h",this);
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description:
// To connect driver and sequencer
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(env_cfg_h.has_virtual_seqr) begin
    virtual_seqr_h.master_seqr_h = master_agent_h.master_seqr_h;
    foreach(slave_agent_h[i]) begin
      virtual_seqr_h.slave_seqr_h = slave_agent_h[i].slave_seqr_h;
    end
  end

  //connecting analysis port to analysis fifo
  
  slave_agent_h[0].slave_mon_proxy_h.slave_analysis_port.connect(scoreboard_h.slave_analysis_fifo.analysis_export);

  master_agent_h.master_mon_proxy_h.master_analysis_port.connect(scoreboard_h.master_analysis_fifo.analysis_export);
endfunction : connect_phase

`endif

