`ifndef SLAVE_AGENT_INCLUDED_
`define SLAVE_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_agent
// This agent has sequencer, driver_proxy, monitor_proxy for SPI  
//--------------------------------------------------------------------------------------------
class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent)

  // Variable: sa_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config sa_cfg_h;

  // Variable: s_sqr_h;
  // Handle for slave sequencer
  slave_sequencer s_sqr_h;

  // Variable: sdrv_proxy_h
  // Handle for slave driver proxy
  slave_driver_proxy sdrv_proxy_h;

  // Variable: smon_proxy_h
  // Handle for slave monitor proxy
  slave_monitor_proxy smon_proxy_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : slave_agent

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes the slave_agent class object
//
// Parameters:
//  name - instance name of the  slave_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_agent::new(string name = "slave_agent",
                               uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",sa_cfg_h)) begin
   `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the slave_agent_config from config_db"))
  end

  // TODO(mshariff): Print the values of the slave_agent_config
  // Have a print method in master_agent_config class and call it from here
  `uvm_info(get_type_name(), $sformatf("The slave_agent_config.slave_id = %0d", sa_cfg_h.slave_id), UVM_LOW);

   if(sa_cfg_h.is_active == UVM_ACTIVE) begin
     sdrv_proxy_h = slave_driver_proxy::type_id::create("sdrv_proxy_h",this);
     s_sqr_h=slave_sequencer::type_id::create("s_sqr_h",this);
   end

   smon_proxy_h = slave_monitor_proxy::type_id::create("smon_proxy_h",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase 
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_agent::connect_phase(uvm_phase phase);
  if(sa_cfg_h.is_active == UVM_ACTIVE) begin
    sdrv_proxy_h.sa_cfg_h = sa_cfg_h;
    s_sqr_h.sa_cfg_h = sa_cfg_h;
  end

  smon_proxy_h.sa_cfg_h = sa_cfg_h;

  //sdrv_proxy_h.seq_item_port.connect(s_sqr_h.seq_item_export);
endfunction: connect_phase

`endif

