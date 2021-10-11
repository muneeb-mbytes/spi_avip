`ifndef MASTER_MONITOR_INCLUDED_
`define MASTER_MONITOR_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_monitor
// Description of the class.
// Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
// A monitor is a passive entity that samples the DUT signals through virtual interface and 
// converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
// Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class master_monitor extends uvm_component;
  
  //register with factory so can use create uvm_method and
  //override in future if necessary 

  `uvm_component_utils(master_monitor)

  //declaring virtual interface
  virtual spi_if.MMON_CB vif;
  
  //declaring handle for master config class
  master_agent_config  m_cfg;
  
  //declaring analysis port for the monitor port
  uvm_analysis_port #(master_xtn)monitor_port;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_monitor", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : master_monitor

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes the master_monitor class component
//
// Parameters:
// name - master_monitor
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_monitor::new(string name = "master_monitor",
                                 uvm_component parent = null);
  //creating monitor port
  monitor_port=new("monitor_port",this);
  
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
// 
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor::build_phase(uvm_phase phase);
     if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
              begin
                  `uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
                         end
    
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// connecting virtual interface with master agent config
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor::connect_phase(uvm_phase phase);
  vif = m_cfg.vif;
  super.connect_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// collecting data in run phase
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_monitor::run_phase(uvm_phase phase);

  phase.raise_objection(this, "master_monitor");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

