`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_sequencer
// Description of the class.
// TODO(mshariff): 
// this class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(virtual_sequencer)

  master_sequencer m_seqr_h;
  slave_sequencer  s_seqr_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_sequencer", uvm_component parent );
  extern virtual function void build_phase(uvm_phase phase);

endclass : virtual_sequencer

  //--------------------------------------------------------------------------------------------
  // Construct: new
  //initializes the mon class object
  //
  // Parameters:
  //  name - instance name of the  virtual_sequencer
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function virtual_sequencer::new(string name = "virtual_sequencer",uvm_component parent );
    super.new(name, parent);
  endfunction : new

  //--------------------------------------------------------------------------------------------
  // Function: build_phase
  // creates the required ports
  //
  // Parameters:
  //  phase - stores the current phase
  //--------------------------------------------------------------------------------------------
  function void virtual_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // MSHA:if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg_h))
    // MSHA:  `uvm_error("VSEQR","COULDNT GET")
    // MSHA:  
    // MSHA:  s_sqr_h = new[e_cfg_h.no_of_sagent];
    m_seqr_h = master_sequencer::type_id::create("m_seqr_h",this);
    s_seqr_h = slave_sequencer::type_id::create("s_seqr_h",this);
  
  endfunction : build_phase


`endif

