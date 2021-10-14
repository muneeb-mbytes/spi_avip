`ifndef master_virtual_sequence_INCLUDED_
`define master_virtual_sequence_INCLUDED_

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
   
   mseq1 m_seq1h;
  //sseq1 s_seq1h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_virtual_sequence",uvm_component parent);
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

   if(!uvm_config_db #(env_config)::get(null,get_full_name,"env_config",e_cfg))
   begin
  `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?")
   end
  
  //declaring no. of  master sequencer in master agent
  //and slave sequencer in slave agent
  
   m_seqr1=new[e_cfg.no_of_magent];
  
   //s_seqr1=new[e_cfg.no_of_sagent];

  //asserting dynamic cast     
  
   assert($cast(v_sequencer,m_seqr1))
   else 
       begin
       `uvm_error("body","error in  $cast of virtual sequencer")
       end
  //connecting master sequencer and slave sequencer in env to
  // master sequencer and slave sequencer in virtual sequencer 
   
   m_seqr1=v_sequencer.m_seqr1;
  
  //s_seqr1=v_sequencer.s_seqr1;

    endtask:body
//--------------------------------------------------------------------------------------------
// extended class from the master_virtual_sequence
//--------------------------------------------------------------------------------------------



`end
