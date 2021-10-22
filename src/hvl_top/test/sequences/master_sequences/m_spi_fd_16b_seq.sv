`ifndef M_SPI_FD_16B_SEQ_INCLUDED_
`define M_SPI_FD_16B_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class m_spi_fd_16b_seq extends master_base_seq;

  //register with factory so can use create uvm_method 
  //and override in future if necessary 

   `uvm_object_utils(m_spi_fd_16b_seq)

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------

   extern function new (string name="m_spi_fd_16b_seq");

   extern virtual task body();
endclass:m_spi_fd_16b_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function m_spi_fd_16b_seq::new(string name="m_spi_fd_16b_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task m_spi_fd_16b_seq::body(); 
  req=master_tx::type_id::create("req");
  repeat(2) begin
  start_item(req);
  if(!req.randomize () with { master_out_slave_in.size()==2;
                            });
  `uvm_fatal(get_type_name,"Randomization failed")
  finish_item(req);
  end
endtask:body

`endif

