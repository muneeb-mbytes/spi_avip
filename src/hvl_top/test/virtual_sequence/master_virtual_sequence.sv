
`ifndef VIRTUAL_SEQUENCE_INCLUDED_
`define VIRTUAL_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_virtual_sequence
// Description of the class
// this class contains transactions
//--------------------------------------------------------------------------------------------
class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

//register with factory so can use create uvm_methods
//and override in future if neccessary

`uvm_object_utils(virtual_sequence)

//  env_config e_cfg;

//declaring handles for master extended class
//  s_seq_1 s_seq_h;

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
extern function new(string name = "virtual_sequence");
extern task body();

endclass :virtual_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
// initialize the master_mon class object
//
// Parameters:
//  name - instance name of the  master_virtual_sequence
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function virtual_sequence::new(string name = "virtual_sequence");
  super.new(name);
endfunction : new
  
//-------------------------------------------------------
//task :body
//creates the required ports
//
//parameters:
//phase -stores the current phase
//-------------------------------------------------------

task virtual_sequence::body();

endtask:body

`endif
