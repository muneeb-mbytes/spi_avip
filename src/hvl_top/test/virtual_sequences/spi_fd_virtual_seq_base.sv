`ifndef SPI_FD_VIRTUAL_SEQ_BASE_INCLUDED_
`define SPI_FD_VIRTUAL_SEQ_BASE_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class:SPI Virtual sequence
// Description:
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class spi_fd_virtual_seq_base extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(spi_fd_virtual_seq_base)

   //p sequencer macro declaration 
   `uvm_declare_p_sequencer(virtual_sequencer)
  
   //declaring virtual sequencer handle
   //virtual_sequencer  virtual_seqr_h;

  //--------------------------------------------------------------------------------------------
  // declaring handles for master and slave sequencer and environment config
  //--------------------------------------------------------------------------------------------
  master_sequencer  master_seqr_h;
  slave_sequencer   slave_seqr_h;
  env_config env_cfg_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="spi_fd_virtual_seq_base");
  extern task body();

endclass:spi_fd_virtual_seq_base

//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  
function spi_fd_virtual_seq_base::new(string name="spi_fd_virtual_seq_base");
  super.new(name);
endfunction:new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task spi_fd_virtual_seq_base::body();
  if(!uvm_config_db#(env_config) ::get(null,get_full_name(),"env_config",env_cfg_h)) begin
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db.Have you set() it?")
  end

  //declaring no of master sequencer in master agent
  //and slave sequencer in slave agent
  // MSHA: m_seqr_h=new[e_cfg_h.no_of_magent];
  // MSHA: s_seqr_h=new[e_cfg_h.no_of_sagent];

  //dynamic casting of p_sequncer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
            
  //connecting master sequencer and slave sequencer present in p_sequencer to
  // local master sequencer and slave sequencer 
  master_seqr_h=p_sequencer.master_seqr_h;
  slave_seqr_h=p_sequencer.slave_seqr_h;

endtask:body

`endif
