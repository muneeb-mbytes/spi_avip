`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
    
    master_agent_config ma_cfg_h;
    master_sequencer m_sqr_h;
    master_driver_proxy mdrv_proxy_h;
    master_monitor_proxy mmon_proxy_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
endclass

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
  if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",ma_cfg_h)) 
  begin
  `uvm_fatal("FATAL_MA_AGENT_CONFIG", $sformatf("Couldn't get the master_agent_config from config_db"))
  end

    if(ma_cfg_h.is_active == UVM_ACTIVE) begin
    mdrv_proxy_h = master_driver_proxy::type_id::create("mdrv_proxy_h",this);
    m_sqr_h=master_sequencer::type_id::create("m_sqr_h",this);
    mmon_proxy_h = master_monitor_proxy::type_id::create("mmon_proxy_h",this);
    end
    else begin
    mmon_proxy_h = master_monitor_proxy::type_id::create("mmon_proxy_h",this);
    end

endfunction : build_phase
//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects driver and sequencer
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
//function void master_agent::connect_phase(uvm_phase phase);
 //   super.connect_phase(phase);
 //     m_drv_proxy_h.seq_item_port.connect(m_sqr_h.seq_item_export);
//    endfunction : connect_phase


`endif

