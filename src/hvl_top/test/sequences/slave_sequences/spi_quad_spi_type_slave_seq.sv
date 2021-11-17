`ifndef SPI_QUAD_SPI_TYPE_SLAVE_SEQ_INCLUDED_
`define SPI_QUAD_SPI_TYPE_SLAVE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class spi_quad_spi_type_slave_seq extends slave_base_seq;

  //register with factory so can use create uvm_method 
  //and override in future if necessary 

   `uvm_object_utils(spi_quad_spi_type_slave_seq)
   //---------------------------------------------
   // Externally defined tasks and functions
   //---------------------------------------------
   extern function new (string name="spi_quad_spi_type_slave_seq");
   extern virtual task body();

endclass:spi_quad_spi_type_slave_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function spi_quad_spi_type_slave_seq::new(string name="spi_quad_spi_type_slave_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task spi_quad_spi_type_slave_seq::body(); 
  req=slave_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize () with {req.master_in_slave_out.size()==1;}) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body

`endif

