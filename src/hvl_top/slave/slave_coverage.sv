`ifndef SLAVE_COVERAGE_INCLUDED_
`define SLAVE_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_coverage
//  <Description_here>
//--------------------------------------------------------------------------------------------
class slave_coverage extends uvm_subscriber;
  `uvm_component_utils(slave_coverage)

  //creating handle for slave transaction coverage

  slave_tx slave_tx_cov_data;

  extern function new(string name = "slave_coverage", uvm_component parent = null);
  
endclass : slave_coverage

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Parameters:
//  name - slave_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_coverage::new(string name = "slave_coverage",uvm_component parent);
  super.new(name, parent);
endfunction : new

`endif
