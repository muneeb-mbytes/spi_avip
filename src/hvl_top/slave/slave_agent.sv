<<<<<<< HEAD
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
=======
  `ifndef SLAVE_AGENT_INCLUDED_
  `define SLAVE_AGENT_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Class: slave_agent
  // <Description_here>
  //--------------------------------------------------------------------------------------------
  class slave_agent extends uvm_agent;

  //register with factory so can use create uvm_method
  //and override in future if necessary

  `uvm_component_utils(slave_agent)
  //declaring handles for agent config driver monitor and sequencer
  slave_agent_config sa_cfg_h;
  slave_driver_proxy s_drv_h;
  slave_monitor_proxy s_mon_h;
  slave_sequencer s_sqr_h;

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

<<<<<<< HEAD
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
   if(!uvm_config_db #(slave_agent_config)::get(this,",","slave_agent_config",sa_cfg_h)) 
    begin
     `uvm_fatal("FATAL_SA_AGENT_CONFIG", $sformatf("Couldn't get the slave_agent_config from config_db"))
    end

   if(sa_cfg_h.is_active == UVM_ACTIVE) begin
     sdrv_proxy_h = slave_driver_proxy::type_id::create("sdrv_proxy_h",this);
     s_sqr_h=slave_sequencer::type_id::create("s_sqr_h",this);
     smon_proxy_h = slave_monitor_proxy::type_id::create("smon_proxy_h",this);
   end
   else begin
     smon_proxy_h = slave_monitor_proxy::type_id::create("smon_proxy_h",this);
   end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects driver and sequencer
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  //sdrv_proxy_h.seq_item_port.connect(s_sqr_h.seq_item_export);
endfunction : connect_phase
=======
  endclass : slave_agent

  //--------------------------------------------------------------------------------------------
  // Construct: new
  //initializes the slave_mon class object
  //
  // Parameters:
  //  name - instance name of the  slave_mon
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function slave_agent::new(string name = "slave_agent",
                                 uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //--------------------------------------------------------------------------------------------
  // Function: build_phase
  // creates the required ports
  //
  // Parameters:
  //  phase - stores the current phase
  //--------------------------------------------------------------------------------------------
  function void slave_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    sa_cfg_h = slave_agent_config::type_id::create("sa_cfg_h");
    s_sqr_h = slave_sequencer::type_id::create("slave_sequencer",this);
    s_drv_h = slave_driver_proxy::type_id::create("slave_driver_proxy",this);
    s_mon_h = slave_monitor_proxy::type_id::create("slave_monitor_proxy",this);
  endfunction : build_phase

  //--------------------------------------------------------------------------------------------
  // Function: connect_phase
  // create the required ports
  //
  // Parameters:
  //  phase - stores the current phase
  //--------------------------------------------------------------------------------------------
  function void slave_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

`endif

