`ifndef MASTER_AGENT_INCLUDED_
`define MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent
<<<<<<< HEAD
//This agent has sequencer,driver_proxy,monitor_proxy for SPI
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)

  //Variable: m_sqr_h;
  //Handle for master agent configuration
    master_agent_config m_cfg_h;

   //Variable: m_sqr_h;
   //Handle for maser sequencer
    master_sequencer m_sqr_h;

   //Variable: m_drv_h;
   //Handle for master driver proxy
    master_driver_proxy m_drv_h;

   //Variable: m_mon_h;
   //Handle for master monitor proxy
    master_monitor_proxy m_mon_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
 extern function new(string name = "master_agent", uvm_component parent);
 extern virtual function void build_phase(uvm_phase phase);
 extern virtual function void connect_phase(uvm_phase phase);

endclass : master_agent

//-------------------------------------------------------------------------------------------------
//construct: new
//Initializes the master_agent class object
//
//Parameters:
//name - instance name of the master_agent
//parent - parent under which this component is create
//------------------------------------------------------------------------------------------------
function  master_agent::new(string name="master_agent",uvm_component parent);
  super.new(name, parent);
=======
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
    master_sequencer m_sqr_h;
    master_driver_proxy m_drv_h;
    master_monitor_proxy m_mon_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
endclass

function  master_agent::new(string name="master_agent",uvm_component parent = null);
  super.new(name,parent);
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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
<<<<<<< HEAD

   if(!uvm_config_db #(master_agent_config)::get(this,",","master_agent_config",m_cfg_h))
   begin
      `uvm_fatal("FATAL_M__AGENT_CONFIG",$sformatf("Couldn't get the master_agent_config from config_db"))
   end
   
   if(m_cfg_h.is_active== UVM_ACTIVE)begin
  m_sqr_h=master_sequencer::type_id::create("m_sqr_h",this);
  m_drv_h=master_driver_proxy::type_id::create("m_drv_h",this);
   //else begin
     //m_mon_h=master_monitor_proxy::type_id::create("m_mon_h",this);
   //end
   end
endfunction : build_phase

//------------------------------------------------------------------------------------------
//Function: connect_phase
//connects driver and sequencer
//
//Parameters:
//phase - stores the current phase
//------------------------------------------------------------------------------------------
function void master_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  //m_drv_h.seq_item_port.connect(m_sqr_h.seq_item_export);
endfunction : connect_phase

=======
  m_sqr_h=master_sequencer::type_id::create("master_sequencer",this);

  m_drv_h=master_driver_proxy::type_id::create("master_driver_proxy",this);
  m_mon_h=master_monitor_proxy::type_id::create("master_monitor_proxy",this);
endfunction : build_phase

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
`endif

