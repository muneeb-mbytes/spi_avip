`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
<<<<<<< HEAD
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;
=======
// 
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_component;
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  `uvm_component_utils(slave_monitor_proxy)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
<<<<<<< HEAD
  extern virtual task run_phase(uvm_phase phase);
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

endclass : slave_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
<<<<<<< HEAD
  // TODO(mshariff): Get the interface
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// // TODO(mshariff): 
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW)

  // Get the data 
  // req.print();

  // Convert to transactions

endtask : run_phase 

`endif
=======
endfunction : build_phase

`endif

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
