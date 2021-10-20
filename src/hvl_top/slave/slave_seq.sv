`ifndef SEQ_INCLUDED_
`define SEQ_INCLUDED_

//-------------------------------------------------------------------------------------------
// Class: seq
// slave sequence
//--------------------------------------------------------------------------------------------
class slave_seq extends uvm_sequence #(slave_tx);
 
  //factory registration
   `uvm_object_utils(slave_seq)

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "slave_seq");
endclass : slave_seq


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function slave_seq::new(string name = "slave_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class s_spi_fd_8b_seq extends slave_seq;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(s_spi_fd_8b_seq)
  
  configuration cfg;

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
  cfg = new();
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//creating request which is will be coming from driver
//-----------------------------------------------------------------------------
 task s_spi_fd_8b_seq::body(); 
    req=slave_tx::type_id::create("req");
    repeat(2) begin
		start_item(req);
    if(!req.randomize () with { master_in_slave_out.size()==2;
                                cfg.cpol == 0;
                                cfg.cphase == 0;
                              });
    `uvm_fatal(get_type_name,"Randomization failed")
    finish_item(req);
  end
endtask:body

`endif

