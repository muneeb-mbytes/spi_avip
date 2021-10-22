`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)

  // Variable: m_cfg
  // Declaring handle for master agent config class 
  master_agent_config m_cfg;


    master_sequencer m_sqr_h;
    master_driver_proxy m_drv_h;
    master_monitor_proxy m_mon_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : master_agent

function  master_agent::new(string name="master_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new
//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg)) begin
    `uvm_fatal("FATAL_MDP_MASTER_CFG_NOT_FOUND_CONFIG_DB","cannot get m_cfg from uvm_config");
  end

  // TODO(mshariff): Print the values of the master_agent_config
  // Have a print method in master_agent_config class and call it from here

  if(m_cfg.is_active == UVM_ACTIVE) begin
    m_drv_h=master_driver_proxy::type_id::create("master_driver_proxy",this);
    m_sqr_h=master_sequencer::type_id::create("master_sequencer",this);
  end

  m_mon_h=master_monitor_proxy::type_id::create("master_monitor_proxy",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase 
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_agent::connect_phase(uvm_phase phase);
  if(m_cfg.is_active == UVM_ACTIVE) begin
    m_drv_h.m_cfg = m_cfg;
    m_sqr_h.m_cfg = m_cfg;
  end

  m_mon_h.m_cfg = m_cfg;
endfunction: connect_phase
`endif

