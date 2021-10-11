`ifndef MASTER_DRIVER_INCLUDED_
`define MASTER_DRIVER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_driver
// <Description_here>
// Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
// Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
// uvm_driver is a parameterized class and it is parameterized with the type of the request 
// sequence_item and the type of the response sequence_item
//--------------------------------------------------------------------------------------------
class master_driver extends uvm_component;
//register with factory so can use create uvm_method and
//override in future if necessary
  `uvm_component_utils(master_driver)

//declaring virtual interface
   virtual spi_if.MDR_CB vif;

//declaring handle for master agent config class 
   master_agent_config m_cfg;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_driver", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : master_driver

//--------------------------------------------------------------------------------------------
//Construct: new
//Initializes the master_driver class component
//
//Parameters:
//name - master_driver
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_driver::new(string name = "master_driver",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
//connecting virtual interface with master agent config
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver::connect_phase(uvm_phase phase);
  vif=m_cfg.vif;
  super.connect_phase(phase);
endfunction : connect_phase


//--------------------------------------------------------------------------------------------
// Task: run_phase
//getting the item from the sequence and giving acknowledgement as item done
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_driver::run_phase(uvm_phase phase);

  phase.raise_objection(this, "master_driver");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase

`endif

