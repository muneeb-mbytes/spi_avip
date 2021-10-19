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
//  slave_driver_proxy sd_proxy_h;
//  slave_monitor_proxy sm_proxy_h;
  slave_sequencer s_sqr_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

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
  // if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",sa_cfg_h))
  // `uvm_fatal("slave_agent","COULDNT GET")

  // if(sa_cfg_h.is_active==UVM_ACTIVE)
  // /*begin
  //   s_drv_h=slave_driver_proxy::type_id::create("s_drv_h",this);
  //   s_sqr_h=slave_sequencer::type_id::create("s_sqr_h",this);
  // end*/
    sa_cfg_h = slave_agent_config::type_id::create("sa_cfg_h");
    s_sqr_h = slave_sequencer::type_id::create("s_sqr_h",this);
  //  sd_proxy_h = slave_driver_proxy::type_id::create("sd_proxy_h",this);
  //  sm_proxy_h = slave_monitor_proxy::type_id::create("sm_proxy_h",this);
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

`endif

