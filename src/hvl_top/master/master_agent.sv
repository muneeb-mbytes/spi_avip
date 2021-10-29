`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
// This agent is a configurable with respect to configuration which can create active and passive components
// It contains testbench components like sequencer,driver_proxy and monitor_proxy for SPI
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
  master_agent_config master_agent_cfg_h;

  // Varible: master_seqr_h 
  // Handle for slave seuencer
  master_sequencer master_seqr_h;
  
  // Variable: master_drv_proxy_h
  // Creating a Handle formaster driver proxy 
  master_driver_proxy master_drv_proxy_h;

  // Variable: master_mon_proxy_h
  // Declaring a handle for master monitor proxy 
  master_monitor_proxy master_mon_proxy_h;
  
  // MSHA: // Variable: master_coverage
  // MSHA: // Decalring a handle for master_coverage
  // MSHA: master_coverage master_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : master_agent

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - instance name of the master_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_agent::new(string name="master_agent", uvm_component parent);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Creates the required ports, gets the required configuration from confif_db
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",master_agent_cfg_h)) begin
    `uvm_fatal("FATAL_MA_CANNOT_GET_MASTER_AGENT_CONFIG","cannot get master_agent_cfg_h from uvm_config_db");
  end

  // Print the values of the master_agent_config
  // Have a print method in master_agent_config class and call it from here
  //`uvm_info(get_type_name(), $sformat("The master_agent_config.master_id =%d",master_agent_cfg_h.master_id),UVM_LOW);
  
  if(master_agent_cfg_h.is_active == UVM_ACTIVE) begin
    master_drv_proxy_h=master_driver_proxy::type_id::create("master_drv_proxy_h",this);
    master_seqr_h=master_sequencer::type_id::create("master_seqr_h",this);
  end

  master_mon_proxy_h=master_monitor_proxy::type_id::create("master_mon_proxy_h",this);

  // MSHA: if(master_agent_cfg_h.has_coverage) begin
  // MSHA:   master_cov_h = master_coverage::type_id::create("master_cov_h",this);
  // MSHA: end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase 
//  Connecting master driver, master monitor and master sequencer for configuration
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_agent::connect_phase(uvm_phase phase);
  if(master_agent_cfg_h.is_active == UVM_ACTIVE) begin
    master_drv_proxy_h.master_agent_cfg_h = master_agent_cfg_h;
    master_seqr_h.master_agent_cfg_h = master_agent_cfg_h;

    //Connecting the ports
    master_drv_proxy_h.seq_item_port.connect(master_seqr_h.seq_item_export);
  end
  
  if(master_agent_cfg_h.has_coverage) begin
    // MSHA: master_cov_h.master_agent_cfg_h = master_agent_cfg_h;
    // TODO(mshariff): 
    // connect monitor port to coverage
  end

  master_mon_proxy_h.master_agent_cfg_h = master_agent_cfg_h;

endfunction: connect_phase

`endif

