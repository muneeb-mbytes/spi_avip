`ifndef SEQ_INCLUDED_
`define SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_seq extends uvm_sequence #(master_tx);
  `uvm_object_utils(master_seq)

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "master_seq");
endclass : master_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - seq
//--------------------------------------------------------------------------------------------
function seq::new(string name = "master_seq");
  super.new(name);
endfunction : new

class spi_fd_8b_seq extends master_seq;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(spi_fd_8b_seq)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new (string name="spi_fd_8b_seq");

extern virtual task body();

endclass:spi_fd_8b_seq



//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function spi_fd_8b_seq::new(string name="spi_fd_8b_seq");
	super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//creating request which is will be coming from driver
//-----------------------------------------------------------------------------
task spi_fd_8b_seq::body(); 
  begin
    req=master_tx::type_id::create("req");
    repeat(2)
  begin
		start_item(req);
    assert(req.randomize () with {  cphase==0;
                                    cpol == 0;
                                    master_data_in==8'b1011_1110;
                                  });
    finish_item(req);
  end
end
endtask:body

`endif

