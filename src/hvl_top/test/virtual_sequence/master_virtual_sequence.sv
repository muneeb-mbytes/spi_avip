`ifndef MASTER_VIRTUAL_SEQUENCE_INCLUDED_
`define MASTER_VIRTUAL_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_virtual_sequence
// Descreption of the class
// This class contains transactions
//--------------------------------------------------------------------------------------------
class master_virtual_sequence extends uvm_sequence #(master_tx);
  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  
  `uvm_object_utils(master_virtual_sequence)

  
   //declaring handles for master and master sequencer and environment config
   master_sequencer m_seq_h;
   env_config e_cfg_h;
  
   //declaring virtual sequencer handle
   
   master_virtual_sequencer mv_sqr_h;
  

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
/*task master_virtual_sequence::body();
  if(!uvm_config_db #(env_config)::get(null,get_full_name(),"ENV_CONFIG",e_cfg_h))
    `uvm_error("vseq","COULDN'T GET")

   s_sqr_h=new[e_cfg_h.no_of_magent];
   
   if(!
  
  
  endtask : body*/
//--------------------------------------------------------------------------------------------
// extended class from the master_virtual_sequence
//--------------------------------------------------------------------------------------------

`endif
