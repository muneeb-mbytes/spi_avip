`ifndef SEQ_INCLUDED_
`define SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class slave_seq extends uvm_sequence #(slave_tx);
  `uvm_object_utils(slave_seq)

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "slave_seq");
endclass : slave_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - seq
//--------------------------------------------------------------------------------------------
function slave_seq::new(string name = "slave_seq");
  super.new(name);
endfunction : new

class spi_fd_8b_seq extends slave_seq;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(spi_fd_8b_seq)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new (string name="spi_fd_8b_seq");

extern virtual task body();

endclass:spi_fd_8b_seq

//class S_spi_fd_8b_test_ct extends slave_seq;
//
////register with factory so can use create uvm_method 
////and override in future if necessary 
//
// `uvm_object_utils(S_spi_fd_8b_test_ct)
//
//
////---------------------------------------------
//// Externally defined tasks and functions
////---------------------------------------------
//extern function new (string name="S_spi_fd_8b_test_ct");
//
//extern virtual task body();
//
//endclass:S_SPI_FD_8b_ct
//
//
//class S_SPI_FD_8b_dct extends slave_seq;
//
////register with factory so can use create uvm_method 
////and override in future if necessary 
//
// `uvm_object_utils(S_SPI_FD_8b_dct)
//
//
////---------------------------------------------
//// Externally defined tasks and functions
////---------------------------------------------
//extern function new (string name="S_SPI_FD_8b_dct");
//
//extern virtual task body();
//
//endclass:S_SPI_FD_8b_dct
//
//
//class S_SPI_RST extends slave_seq;
//
////register with factory so can use create uvm_method 
////and override in future if necessary 
//
// `uvm_object_utils(S_SPI_RST)
//
//
////---------------------------------------------
//// Externally defined tasks and functions
////---------------------------------------------
//extern function new (string name="S_SPI_RST");
//
//extern virtual task body();
//
//endclass:S_SPI_RST
//
//
//class S_SPI_HD_8b extends slave_seq;
//
////register with factory so can use create uvm_method 
////and override in future if necessary 
//
// `uvm_object_utils(S_SPI_HD_8b)
//
//
////---------------------------------------------
//// Externally defined tasks and functions
////---------------------------------------------
//extern function new (string name="S_SPI_HD_8b");
//
//extern virtual task body();
//
//endclass:S_SPI_HD_8b

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
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
    req=slave_tx::type_id::create("req");
    repeat(2)
  begin
		start_item(req);
    assert(req.randomize () with { cphase==0; 
                                   cpol==0;
                                   slave_data_in==8'b1011_1010;
                              });
    req.print();
    finish_item(req);
  end
end
endtask:body


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
//function S_SPI_FD_8b_ct::new(string name="S_SPI_FD_8b_ct");
//	super.new(name);
//endfunction:new
//
////-----------------------------------------------------------------------------
////task:body
////creating request which is will be coming from driver
////-----------------------------------------------------------------------------
//task S_SPI_FD_8b_ct::body(); 
//  begin
//    req=slave_tx::type_id::create("req");
//    for(int i=0; i < 8;i++)
//  begin
//		start_item(req);
//    assert(req.randomize () with {rst==0;});
//    finish_item(req);
//  end
//end
//endtask:body
//
//
////-----------------------------------------------------------------------------
//// Constructor: new
//// Initializes the slave_sequence class object
////
//// Parameters:
////  name - instance name of the config_template
////-----------------------------------------------------------------------------
//function S_SPI_FD_8b_dct::new(string name="S_SPI_FD_8b_dct");
//	super.new(name);
//endfunction:new
//
////-----------------------------------------------------------------------------
////task:body
////creating request which is will be coming from driver
////-----------------------------------------------------------------------------
//task S_SPI_FD_8b_dct::body(); 
//  begin
//    req=slave_tx::type_id::create("req");
//    for(int i=0; i < 8;i++)
//  begin
//		start_item(req);
//    assert(req.randomize () with { cs==2'b0;
//                                   rst==0;
//                                 });  
//    assert(req.randomize () with {cs==2'b1;});
//    continue;
//    finish_item(req);
//  end
//end
//endtask:body
//
//
////-----------------------------------------------------------------------------
//// Constructor: new
//// Initializes the slave_sequence class object
////
//// Parameters:
////  name - instance name of the config_template
////-----------------------------------------------------------------------------
//function S_SPI_RST::new(string name="S_SPI_RST");
//	super.new(name);
//endfunction:new
//
////-----------------------------------------------------------------------------
////task:body
////creating request which is will be coming from driver
////-----------------------------------------------------------------------------
//task S_SPI_RST::body(); 
//  begin
//    req=slave_tx::type_id::create("req");
//    repeat(1)
//  begin
//		start_item(req);
//    assert(req.randomize () with {rst == 1;});
//    finish_item(req);
//  end
//end
//endtask:body
//
//
////-----------------------------------------------------------------------------
//// Constructor: new
//// Initializes the slave_sequence class object
////
//// Parameters:
////  name - instance name of the config_template
////-----------------------------------------------------------------------------
//function S_SPI_HD_8b::new(string name="S_SPI_HD_8b");
//	super.new(name);
//endfunction:new
//
////-----------------------------------------------------------------------------
////task:body
////creating request which is will be coming from driver
////-----------------------------------------------------------------------------
//task S_SPI_HD_8b::body(); 
//  begin
//    req=slave_tx::type_id::create("req");
//    repeat(1)
//  begin
//		start_item(req);
//    assert(req.randomize () with { 
//                                   rst == 1;
//                                });
//    finish_item(req);
//  end
//end
//endtask:body
//
`endif

