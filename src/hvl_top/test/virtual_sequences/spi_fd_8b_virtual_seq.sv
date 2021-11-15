`ifndef SPI_FD_8b_VIRTUAL_SEQ_INCLUDED_
`define SPI_FD_8b_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Extended class from spi virtual sequence
//--------------------------------------------------------------------------------------------
class spi_fd_8b_virtual_seq extends spi_fd_virtual_seq_base;
  `uvm_object_utils(spi_fd_8b_virtual_seq)

  // declare extended class handles of master and slave sequence
  spi_fd_8b_master_seq spi_fd_8b_master_seq_h;
  spi_fd_8b_slave_seq spi_fd_8b_slave_seq_h;
  
  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="spi_fd_8b_virtual_seq");
  extern task body();

endclass : spi_fd_8b_virtual_seq

//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_fd_8b_virtual_seq::new(string name="spi_fd_8b_virtual_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task spi_fd_8b_virtual_seq::body();
 super.body(); //Sets up the sub-sequencer pointer

   //crearions master and slave sequence handles here  
   spi_fd_8b_master_seq_h=spi_fd_8b_master_seq::type_id::create("spi_fd_8b_master_seq_h");
   spi_fd_8b_slave_seq_h=spi_fd_8b_slave_seq::type_id::create("spi_fd_8b_slave_seq_h");

   //spi_fd_8b_master_seq_h.req.print();
  
 
   //configuring no of masters and starting master sequencers

  // Slave sequence(s) must be started in parallel in fork-join_none
  // This is because, the slave must respond to the master
  fork 
    forever begin : SLAVE_0_SEQUENCE
      // TODO(mshariff): Update this for multiple slaves
      spi_fd_8b_slave_seq_h.start(p_sequencer.slave_seqr_h);
    end
  join_none


  // TODO(mshariff): Only one Master agent as SPI supports only one Master
  repeat(5) begin : MASTER_SEQ_START
   spi_fd_8b_master_seq_h.start(p_sequencer.master_seqr_h);
  end

endtask: body

`endif
