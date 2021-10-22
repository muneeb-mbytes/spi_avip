`ifndef VSEQ1_FD_16b_SEQ_INCLUDED_
`define VSEQ1_FD_16b_SEQ_INCLUDED_
//--------------------------------------------------------------------------------------------
// Extended class from spi virtual sequence
//--------------------------------------------------------------------------------------------
class vseq1_fd_16b_seq extends spi_fd_vseq_base;
  
  `uvm_object_utils(vseq1_fd_16b_seq)

  //declare extended class handles of master and slave sequence

    m_spi_fd_16b_seq m_spi_fd_16b_h;
    s_spi_fd_16b_seq s_spi_fd_16b_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="vseq1_fd_16b_seq");
  extern task body();

endclass : vseq1_fd_16b_seq


//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------

function vseq1_fd_16b_seq::new(string name="vseq1_fd_16b_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------

task vseq1_fd_16b_seq::body();
 super.body(); //Sets up the sub-sequencer pointer

   //crearions master and slave sequence handles here  
    m_spi_fd_16b_h=m_spi_fd_16b_seq::type_id::create("m_spi_fd_16b_h");
    s_spi_fd_16b_h=s_spi_fd_16b_seq::type_id::create("s_spi_fd_16b_h");

    //configuring no of masters and starting master sequencers

  fork
  begin
    //has_m_agt should be declared in env_config file
    if(e_cfg_h.has_m_agt)begin
    //no_of_magent should be declared in env_config file
    for(int i=0; i<e_cfg_h.no_of_magent; i++)begin
      //starting master sequencer
      m_spi_fd_16b_h.start(m_seqr_h);
      end
    end
  end
    begin
      //has_s_agt should be declared in env_config file
      if(e_cfg_h.has_s_agt) begin 
        //no_of_sagent should be declared in env_config file
      for(int i=0; i<e_cfg_h.no_of_sagent; i++)begin
        //starting slave sequencer
       s_spi_fd_16b_h.start(s_seqr_h);
   end
 end
 end
 join

endtask: body

`endif
