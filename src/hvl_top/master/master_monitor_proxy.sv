`ifndef MASTER_MONITOR_PROXY_INCLUDED_
`define MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: master_monitor_proxy
//  <Description of the class
//  Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
//  A monitor is a passive entity that samples the DUT signals through virtual interface and 
//  converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
//  Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class master_monitor_proxy extends uvm_component; 
  `uvm_component_utils(master_monitor_proxy)
  
  // Variable: master_agent_cfg_h
  // Declaring handle for master agent config class 
  master_agent_config master_agent_cfg_h;
    
  //declaring analysis port for the monitor port
  uvm_analysis_port #(master_tx)master_analysis_port;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_monitor_proxy", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  // extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // extern virtual function void start_of_simulation_phase(uvm_phase phase);

endclass : master_monitor_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_monitor_proxy::new(string name = "master_monitor_proxy",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",master_agent_cfg_h)) begin
  `uvm_fatal("FATAL_MASTER_MONITOR_PROXY_CANNOT_GET_MASTER_AGENT_CONFIG","cannot get() master_agent_cfg_h from uvm_config_db");
  end 
  // creating monitor port
   master_analysis_port=new("master_analysis_port",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::connect_phase(uvm_phase phase);

 
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
//  Function: end_of_elaboration_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void master_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
//  super.end_of_elaboration_phase(phase);
//endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void master_monitor_proxy::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
//  Task: run_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//task master_monitor_proxy::run_phase(uvm_phase phase);

//  phase.raise_objection(this, "master_monitor_proxy");

//  super.run_phase(phase);

//  phase.drop_objection(this);

//endtask : run_phase

`endif

