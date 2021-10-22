`ifndef MASTER_SEQUENCER_INCLUDED_
`define MASTER_SEQUENCER_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Class: master_sequencer
 //--------------------------------------------------------------------------------------------
 class master_sequencer extends uvm_sequencer #(master_tx);
  
  //register with factory so we can override it in further by using uvm method.

  `uvm_component_utils(master_sequencer)

  // Variable: m_cfg
  // Declaring handle for master agent config class 
  master_agent_config m_cfg;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_sequencer", uvm_component parent);
 
 endclass : master_sequencer
 
 //--------------------------------------------------------------------------------------------
 // Construct: new
 // initializes the master sequencer class component
 //
 // Parameters:
 // name - master_sequencer
 // parent - parent under which this component is created
 //--------------------------------------------------------------------------------------------
 function master_sequencer::new(string name = "master_sequencer",uvm_component parent);
  super.new(name,parent);
 endfunction : new


`endif
