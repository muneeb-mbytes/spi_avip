`ifndef CONFIGURATION_INCLUDED_
`define CONFIGURATION_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: config
// configuration class 
//--------------------------------------------------------------------------------------------
class configuration extends uvm_object;

   `uvm_object_utils(configuration)
   
   rand  bit [1:0] cpol;
   rand  bit [1:0] cphase;

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
extern function new(string name = "configuration");
endclass : configuration
//--------------------------------------------------------------------------------------------
// Construct: new
// Parameters:
//  name - configuration
//--------------------------------------------------------------------------------------------
 function configuration::new(string name = "configuration");
  super.new(name);
 endfunction : new
 
`endif
