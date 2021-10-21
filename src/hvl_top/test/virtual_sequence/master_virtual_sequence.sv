<<<<<<< HEAD
`ifndef MASTER_VIRTUAL_SEQUENCE_INCLUDED_
`define MASTER_VIRTUAL_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_virtual_sequence
// Descreption of the class
// This class contains transactions
//--------------------------------------------------------------------------------------------
class master_virtual_sequence extends uvm_sequence #(master_tx);
  
=======
`ifndef master_virtual_sequence_INCLUDED_
`define master_virtual_sequence_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_virtual_sequence
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_virtual_sequence extends uvm_sequence;
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  
  `uvm_object_utils(master_virtual_sequence)
<<<<<<< HEAD

  
   //declaring handles for master and master sequencer and environment config
   master_sequencer m_seq_h;
   env_config e_cfg_h;
  
   //declaring virtual sequencer handle
   
   master_virtual_sequencer mv_sqr_h;
  
=======
  
  //declaring handles for master and slave sequencer and environment config
   
   master_sequencer m_seqr1;
  
   //slave_sequencer s_seqr1;
   
//   env_config e_cfg;
  
  //declaring virtual sequencer handle
   
   master_virtual_sequencer v_sequencer;
  
  //declaring handles for master and slave extended class
   
   mseq1 m_seq1h;
  //sseq1 s_seq1h;
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
<<<<<<< HEAD
  extern function new(string name = "master_virtual_sequence");
  
=======
  extern function new(string name = "master_virtual_sequence",uvm_component parent);
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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
<<<<<<< HEAD
/*task master_virtual_sequence::body();
  if(!uvm_config_db #(env_config)::get(null,get_full_name(),"ENV_CONFIG",e_cfg_h))
    `uvm_error("vseq","COULDN'T GET")

   s_sqr_h=new[e_cfg_h.no_of_magent];
   
   if(!
  
  
  endtask : body*/
=======
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
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
//--------------------------------------------------------------------------------------------
// extended class from the master_virtual_sequence
//--------------------------------------------------------------------------------------------

<<<<<<< HEAD
`endif
=======


`end
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
