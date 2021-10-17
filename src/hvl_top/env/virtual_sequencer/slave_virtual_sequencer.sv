  `ifndef SLAVE_VIRTUAL_SEQUENCER_INCLUDED_
  `define SLAVE_VIRTUAL_SEQUENCER_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Class: slave_virtual_sequencer
  // Description of the class.
  // this class contains the handle of actual sequencer pointing towards them
  //--------------------------------------------------------------------------------------------
  class slave_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

  //register with factory so can use create uvm_method
  //and override in future if neccessary

  `uvm_component_utils(slave_virtual_sequencer)
  
  //declaring handles for slave_sequencer and environment config

    slave_sequencer s_sqr_h;
  //  virtual_sequence v_seq_h;
  //  env_config e_cfg;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_virtual_sequencer", uvm_component parent );
  extern virtual function void build_phase(uvm_phase phase);
  
  endclass : slave_virtual_sequencer

  //--------------------------------------------------------------------------------------------
  // Construct: new
  //initializes the slave_mon class object
  //
  // Parameters:
  //  name - instance name of the  slave_virtual_sequencer
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function slave_virtual_sequencer::new(string name = "slave_virtual_sequencer",uvm_component parent );
    super.new(name, parent);
  endfunction : new

  //--------------------------------------------------------------------------------------------
  // Function: build_phase
  // creates the required ports
  //
  // Parameters:
  //  phase - stores the current phase
  //--------------------------------------------------------------------------------------------
  function void slave_virtual_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  //--------------------------------------------------------------------------------------------

`endif

