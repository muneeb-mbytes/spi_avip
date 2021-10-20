`ifndef MASTER_SEQUENCE_INCLUDED_
`define MASTER_SEQUENCE_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Class: master_sequence
 // <Description_here>
 //--------------------------------------------------------------------------------------------
 class master_sequence extends uvm_sequence #(master_tx);

  //register with factory so we can ovverride using uvm methos in future.

  `uvm_object_utils(master_sequence)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
   extern function new(string name = "master_sequence");
  
 endclass : master_sequence

 //--------------------------------------------------------------------------------------------
 // Construct: new
 //
 // Parameters:
 //  name - master_sequence
 //--------------------------------------------------------------------------------------------
 function master_sequence::new(string name = "master_sequence");
   super.new(name);
 endfunction : new

`endif

