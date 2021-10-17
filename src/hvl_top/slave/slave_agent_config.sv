  `ifndef SLAVE_AGENT_CONFIG_INCLUDED_
  `define SLAVE_AGENT_CONFIG_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Class: slave_agent_config
  // Description of the class
  // this class is used to get env_config and set the agent config
  //--------------------------------------------------------------------------------------------
  class slave_agent_config extends uvm_object;

  //register with factory so can use create uvm_method
  //and override in future if neccessary
    
  `uvm_object_utils(slave_agent_config)

  //declare handle for virtual interface
    virtual spi_if vif;

  //declaring agent is active or passive

    uvm_active_passive_enum is_active=UVM_ACTIVE;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_agent_config");

  endclass : slave_agent_config

  //--------------------------------------------------------------------------------------------
  // Construct: new
  //initializes the slave_mon class object
  //
  // Parameters:
  //  name - instance name of the slave_mon
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function slave_agent_config::new(string name = "slave_agent_config");
    super.new(name);
  endfunction : new


  `endif
        
