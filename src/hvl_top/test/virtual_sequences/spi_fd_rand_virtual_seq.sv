`ifndef SPI_FD_RAND_VIRTUAL_SEQ_INCLUDED_
`define SPI_FD_RAND_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Extended class from spi virtual sequence
//--------------------------------------------------------------------------------------------
class spi_fd_rand_virtual_seq extends spi_fd_virtual_seq_base;
  
  `uvm_object_utils(spi_fd_rand_virtual_seq)

  //declare extended class handles of master and slave sequence
  spi_fd_rand_master_seq spi_fd_rand_master_seq_h;
  spi_fd_rand_slave_seq spi_fd_rand_slave_seq_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="spi_fd_rand_virtual_seq");
  extern task body();

endclass : spi_fd_rand_virtual_seq

//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_fd_rand_virtual_seq::new(string name="spi_fd_rand_virtual_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task spi_fd_rand_virtual_seq::body();
   //creations master and slave sequence handles here  
   spi_fd_rand_master_seq_h = spi_fd_rand_master_seq::type_id::create("spi_fd_rand_master_seq_h");
   spi_fd_rand_slave_seq_h = spi_fd_rand_slave_seq::type_id::create("spi_fd_rand_slave_seq_h");
 
   super.body(); //Sets up the sub-sequencer pointer


  fork
      // TODO(mshariff): We need to connect the slaves with caution
      // as only ONe slave can drive on MISO line
      // so the sequences need to be started based on the System config_cpol0_cpha0_msb_c2t_t2c_baudrate

      //starting slave sequencer
      forever begin: SLAVE_SEQ_START
        spi_fd_rand_slave_seq_h.start(p_sequencer.slave_seqr_h);
      end
  join_none

    //has_m_agt should be declared in env_config file
    // TODO(mshariff): Only one Master agent as SPI supports only one Master

    // MSHA: if(e_cfg_h.has_m_agt)begin
    // MSHA: //no_of_magent should be declared in env_config file
    // MSHA: for(int i=0; i<e_cfg_h.no_of_magent; i++)begin
    // MSHA:   //starting master sequencer
    // MSHA:   spi_fd_config_cpol0_cpha0_msb_c2t_t2c_baudrate_master_seq_h.start(m_seqr_h);
    // MSHA:   end
    // MSHA: end

    //starting master sequencer
    repeat(5)begin: MASTER_SEQ_START
      spi_fd_rand_master_seq_h.start(p_sequencer.master_seqr_h);
    end

endtask: body

`endif
