//-------------------------------------------------------
//
//
//-------------------------------------------------------
  class virtual_sequencer extends uvm_sequencer;
    `uvm_components_utils(master_virtual_sequencer)

     function new(string name="master_virtual_sequencer",uvm_component parent);
       super.new(name,parent);
     endfunction

     master_sequencer m_seqr~:w;


   endclass
