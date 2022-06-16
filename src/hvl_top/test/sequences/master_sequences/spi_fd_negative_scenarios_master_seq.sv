`ifndef SPI_FD_NEGATIVE_SCENARIOS_MASTER_SEQ_INCLUDED_
`define SPI_FD_NEGATIVE_SCENARIOS_MASTER_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class spi_fd_negative_scenarios_master_seq extends master_base_seq;

  //register with factory so can use create uvm_method 
  //and override in future if necessary 

   `uvm_object_utils(spi_fd_negative_scenarios_master_seq)

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
   extern function new (string name="spi_fd_negative_scenarios_master_seq");
   extern virtual task body();

endclass:spi_fd_negative_scenarios_master_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function spi_fd_negative_scenarios_master_seq::new(string name="spi_fd_negative_scenarios_master_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task spi_fd_negative_scenarios_master_seq::body(); 
  req=master_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize() with {req.master_out_slave_in.size() <  MAXIMUM_BITS / CHAR_LENGTH;
                            // selecting only one slave  
                            $countones(req.cs) == NO_OF_SLAVES - 1;
                            // selecting slave 0
                            req.cs[0] == 0;
                           }) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body

`endif

