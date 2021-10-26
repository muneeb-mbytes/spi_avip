`ifndef S_SPI_FD_8B_SEQ_INCLUDED_
`define S_SPI_FD_8B_SEQ_INCLUDED_
//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class s_spi_fd_8b_seq extends slave_base_seq;

  //register with factory so can use create uvm_method
  //and override in future if necessary 

 `uvm_object_utils(s_spi_fd_8b_seq)


  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new (string name="s_spi_fd_8b_seq");

  extern virtual task body();

endclass:s_spi_fd_8b_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function s_spi_fd_8b_seq::new(string name="s_spi_fd_8b_seq");
  super.new(name);
endfunction : new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task s_spi_fd_8b_seq::body(); 
  req=slave_tx::type_id::create("req");
  repeat(2) begin
  start_item(req);
  if(!req.randomize () with { master_in_slave_out.size()==1;
                            });
  `uvm_fatal(get_type_name,"Randomization failed")
  finish_item(req);
  end
endtask : body

`endif

