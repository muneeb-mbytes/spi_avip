`ifndef TEST_DUP_INCLUDED_
`define TEST_DUP_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: test_dup
// <Description_here>
//--------------------------------------------------------------------------------------------
class test_dup extends uvm_test;
  `uvm_component_utils(test_dup)
       env envh;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "test_dup", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);

endclass : test_dup

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - test_dup
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function test_dup::new(string name = "test_dup", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void test_dup::build_phase(uvm_phase phase);
  super.build_phase(phase);
   envh=env::type_id::create("envh",this);
   
endfunction : build_phase

 
function void test_dup::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
  
endfunction : end_of_elaboration_phase



`endif

