`ifndef MTEST_INCLUDED_
`define MTEST_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: mtest
// <Description_here>
//--------------------------------------------------------------------------------------------
class mtest extends uvm_test;
  `uvm_component_utils(mtest)
   env envh;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "mtest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);

endclass : mtest

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - mtest
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function mtest::new(string name = "mtest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void mtest::build_phase(uvm_phase phase);
  super.build_phase(phase);
  envh=env::type_id::create("envh",this);
endfunction : build_phase

 
function void mtest::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase
`endif
