`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
// master_agent is a container class 
// which consists of driver_proxy,monitor_proxy,sequencer for SPI
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
<<<<<<< HEAD
    
    master_agent_config ma_cfg_h;
    master_sequencer m_sqr_h;
    master_driver_proxy mdrv_proxy_h;
    master_monitor_proxy mmon_proxy_h;
=======
  
  //Variable:m_cfg_h
  //Declaring handle for master config class
  master_agent_config m_cfg_h;
  //variable:m_sqr_h
  //Declaring handle for master sequenecr 
  master_sequencer m_sqr_h;
  //variable:m_drv_proxy_h
  //Declaring handle for master driver proxy
  master_driver_proxy m_drv_proxy_h;
  //variable:m_mon_proxy_h
  //declaring handle for master monitor proxy
  master_monitor_proxy m_mon_proxy_h;
>>>>>>> 966a5b0eb70ad0a709d68f63396f50824679929f
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new (string name = "master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
<<<<<<< HEAD
  //extern virtual function void connect_phase(uvm_phase phase);
endclass
=======
  extern function void connect_phase ( uvm_phase phase);
>>>>>>> 966a5b0eb70ad0a709d68f63396f50824679929f

endclass: master_agent
  
//--------------------------------------------------------------------------------------------
//Constructor: new
//
//Parameters:
//name - instace name of the config_template
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function  master_agent::new(string name="master_agent",uvm_component parent = null);
  super.new(name,parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// creates the required ports and gets the required configuration from config_db
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
<<<<<<< HEAD
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
=======
  
  //if(!uvm_config_db  #(master_agent_config)::get(this,"","master_agent_config",m_cfg_h))
  //  `uvm_fatal("FATAL_MA_AGENT_CONFIG",$sformatf("couldn't get the master_agent_config from
  //  config_db"))

  //if(m_cfg_h.is_active == UVM_ACTIVE) begin
  //  m_sqr_h = master_sequencer::type_id::create("master_sequencer",this);
  //  m_drv_proxy_h = master_driver_proxy::type_id::create("master_driver_proxy",this);
  //  m_mon_proxy_h = master_monitor_proxy::type_id::create("master_monitor_proxy",this);
>>>>>>> 966a5b0eb70ad0a709d68f63396f50824679929f

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


//--------------------------------------------------------------------------------------------
// Function: connect_phase
// connects driver and sequenecr
//--------------------------------------------------------------------------------------------
function void master_agent::connect_phase(uvm_phase phase);
  super.build_phase(phase);
  //m_drv_proxy_h.seq_item_port.connect(m_sqr_h.seq_item_export);
endfunction:connect_phase
 
`endif

