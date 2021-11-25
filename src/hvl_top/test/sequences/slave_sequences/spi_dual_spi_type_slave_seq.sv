`ifndef SPI_DUAL_SPI_TYPE_SLAVE_SEQ_INCLUDED_
`define SPI_DUAL_SPI_TYPE_SLAVE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class spi_dual_spi_type_slave_seq extends slave_base_seq;

  //register with factory so can use create uvm_method 
  //and override in future if necessary 

   `uvm_object_utils(spi_dual_spi_type_slave_seq)
   //---------------------------------------------
   // Externally defined tasks and functions
   //---------------------------------------------
   extern function new (string name="spi_dual_spi_type_slave_seq");
   extern virtual task body();

endclass:spi_dual_spi_type_slave_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function spi_dual_spi_type_slave_seq::new(string name="spi_dual_spi_type_slave_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task spi_dual_spi_type_slave_seq::body(); 
  req=slave_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize () with {req.miso0.size()==CHAR_LENGTH/2;
                             req.miso1.size()==CHAR_LENGTH/2;}) begin
    `uvm_fatal(get_type_name(),"Randomization failed")
  end
  `uvm_info(get_type_name(),$sformatf("slave_seq = \n %0p",req.sprint()),UVM_MEDIUM)

  finish_item(req);

endtask:body

`endif

