`ifndef MASTER_BASE_SEQ_INCLUDED_
`define MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_base_seq 
// creating master_base_seq class extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class master_base_seq extends uvm_sequence #(master_tx);
  //factory registration
  `uvm_object_utils(master_base_seq)

  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "master_base_seq");
endclass : master_base_seq


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function master_base_seq::new(string name = "master_base_seq");
  super.new(name);
endfunction : new

//`define uvm_declare_p_sequencer(SEQUENCER)\
//SEQUENCER p_sequencer;\
//virtual function void m_set_p_sequencer();\
//super.m_set_p_sequencer();\
//if(!$cast(p_seqencer,m_sequencer))\
//  `uvm_fatal("SQ",$sformatf("%s Error casting p_sequncer,please verify sequence",get_full_name()))\
//endfunction

`endif
