`ifndef MASTER_VIRTUAL_SEQUENCE_INCLUDED_
`define MASTER_VIRTUAL_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_virtual_sequence
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_virtual_sequence extends uvm_sequence;
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  
  `uvm_object_utils(master_virtual_sequence)
  
  //declaring handles for master and slave sequencer and environment config
   
   master_sequencer m_seqr1;
  
   //slave_sequencer s_seqr1;
   
//   env_config e_cfg;
  
  //declaring virtual sequencer handle
   
   master_virtual_sequencer v_sequencer;
  
  //declaring handles for master and slave extended class
   
  // TODO(mshariff): Have better naming philosophy 
  //  mseq1 m_seq1h;
  //sseq1 s_seq1h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_virtual_sequence");
  extern task body();
endclass : master_virtual_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_virtual_sequence
//--------------------------------------------------------------------------------------------
function master_virtual_sequence::new(string name = "master_virtual_sequence");
  super.new(name);
endfunction : new
//--------------------------------------------------------------------------------------------
// task : body 
// create the required port 
// parameter:
// phase - store the current phase 
//--------------------------------------------------------------------------------------------
task master_virtual_sequence::body();

// MSHA:    if(!uvm_config_db #(env_config)::get(null,get_full_name,"env_config",e_cfg))
// MSHA:    begin
// MSHA:   `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?")
// MSHA:    end
// MSHA:   
// MSHA:   //declaring no. of  master sequencer in master agent
// MSHA:   //and slave sequencer in slave agent
// MSHA:   
// MSHA:    m_seqr1=new[e_cfg.no_of_magent];
// MSHA:   
// MSHA:    //s_seqr1=new[e_cfg.no_of_sagent];
// MSHA: 
// MSHA:   //asserting dynamic cast     
// MSHA:   
// MSHA:    assert($cast(v_sequencer,m_seqr1))
// MSHA:    else 
// MSHA:        begin
// MSHA:        `uvm_error("body","error in  $cast of virtual sequencer")
// MSHA:        end
// MSHA:   //connecting master sequencer and slave sequencer in env to
// MSHA:   // master sequencer and slave sequencer in virtual sequencer 
// MSHA:    
// MSHA:    // TODO(mshariff): m_seqr1=v_sequencer.m_seqr1;
// MSHA:   
// MSHA:   //s_seqr1=v_sequencer.s_seqr1;

    endtask:body
//--------------------------------------------------------------------------------------------
// extended class from the master_virtual_sequence
//--------------------------------------------------------------------------------------------

`endif
