`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_driver_proxy
<<<<<<< HEAD
// This is the proxy driver on the HVL side
// It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_driver#(slave_tx);
=======
// <Description_here>
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_component;
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  `uvm_component_utils(slave_driver_proxy)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
<<<<<<< HEAD
  extern virtual task run_phase(uvm_phase phase);
=======
  //extern virtual task run_phase();
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
<<<<<<< HEAD
// // TODO(mshariff): add comments
=======
//
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
// Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
<<<<<<< HEAD
// // TODO(mshariff): COmments
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
<<<<<<< HEAD
  // TODO(mshariff): get the interface handle
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// // TODO(mshariff): 
//--------------------------------------------------------------------------------------------
task slave_driver_proxy::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Inside the slave_driver_proxy"), UVM_LOW)

  // Get the next item
  // req.print();

  // Drive to the DUT

endtask : run_phase 

`endif
=======
endfunction : build_phase

/*task run_phase();
  req.print();
endtask
*/

`endif

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
