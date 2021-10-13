`define VIRTUAL_SEQUENCER_INCLUDED
`ifndef VIRTUAL_SEQUENCER_INCLUDED
//-------------------------------------------------------
//Class virtual sequencer 
//
//-------------------------------------------------------
  class virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(virtual_sequencer)

     function new(string name="master_virtual_sequencer",uvm_component parent);
       super.new(name,parent);
     endfunction
//-------------------------------------------------------
//Here the name of the sequencer is master_sequencer
//and the handle assigned is m_seqr
//-------------------------------------------------------
   //  master_sequencer m_seqr;


   endclass

`endif
