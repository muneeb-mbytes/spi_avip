`ifndef SLAVE_SEQUENCE_INCLUDED_
`define SLAVE_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_sequence
//  Slave_sequence is extended from uvm_sequence to create sequence items
//--------------------------------------------------------------------------------------------
class slave_sequence extends uvm_sequence #(slave_tx);
  `uvm_object_utils(slave_sequence)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_sequence");

endclass : slave_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes new memory for slave_sequence
//
// Parameters:
//  name - slave_sequence
//--------------------------------------------------------------------------------------------
function slave_sequence::new(string name = "slave_sequence");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Class: seq extended from base class
//--------------------------------------------------------------------------------------------
class s_seq_1 extends slave_sequence;
  `uvm_object_utils(s_seq_1)

  //-------------------------------------------------------
  // Externally defined tasks and functions
  //-------------------------------------------------------
  extern function new(string name = "s_seq_1");
  extern virtual task body();

endclass : s_seq_1

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes sseq1 class object 
//
// Parameters:
//  name - sseq1
//--------------------------------------------------------------------------------------------
function s_seq_1::new(string name = "s_seq_1");
  super.new(name);
endfunction : new

//-------------------------------------------------------
// task:body
//  To create request which is comes from driver
//-------------------------------------------------------

task s_seq_1::body();
  repeat(1) begin
    req = slave_tx::type_id::create("req");
	   start_item(req);
     if(req.randomize () with {cpol==0; cpha==0; data_master_in_slave_out == 8'b10010010;});
       `uvm_info("slave_sequence",$sformatf("printing from sequence %s", req.sprint()),UVM_LOW) 
	   finish_item(req); 
  end

endtask : body

`endif

