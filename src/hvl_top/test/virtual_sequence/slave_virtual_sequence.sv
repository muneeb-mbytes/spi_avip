  `ifndef SLAVE_VIRTUAL_SEQUENCE_INCLUDED_
  `define SLAVE_VIRTUAL_SEQUENCE_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Class: slave_virtual_sequence
  // Description of the class
  // this class contains transactions
  //--------------------------------------------------------------------------------------------
  class slave_virtual_sequence extends uvm_sequence #(slave_tx);

  //register with factory so can use create uvm_methods
  //and override in future if neccessary

  `uvm_object_utils(slave_virtual_sequence)

  //  env_config e_cfg;

  //declaring handles for slave extended class
  //  s_seq_1 s_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_virtual_sequence");
  extern task body();

  endclass : slave_virtual_sequence

  //--------------------------------------------------------------------------------------------
  // Construct: new
  // initialize the slave_mon class object
  //
  // Parameters:
  //  name - instance name of the  slave_virtual_sequence
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function slave_virtual_sequence::new(string name = "slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  //-------------------------------------------------------
  //task :body
  //creates the required ports
  //
  //parameters:
  //phase -stores the current phase
  //-------------------------------------------------------

  task slave_virtual_sequence::body();

  endtask:body

`endif

