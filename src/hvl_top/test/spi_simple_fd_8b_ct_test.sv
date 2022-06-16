`ifndef SPI_SIMPLE_FD_8B_CT_TEST_INCLUDED_
`define SPI_SIMPLE_FD_8B_CT_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_8b_ct_test
// Description:
// Extended the spi_simple_fd_8b_ct_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_8b_ct_test extends base_test;

  //Registering the spi_simple_fd_8b_ct_test in the factory
  `uvm_component_utils(spi_simple_fd_8b_ct_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  spi_fd_8b_ct_virtual_seq spi_fd_8b_ct_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_8b_ct_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : spi_simple_fd_8b_ct_test


//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_8b_ct_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_8b_ct_test::new(string name = "spi_simple_fd_8b_ct_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_8b_ct_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_simple_fd_8b_ct_test::run_phase(uvm_phase phase);
  
  spi_fd_8b_ct_virtual_seq_h = spi_fd_8b_ct_virtual_seq::type_id::create("spi_fd_8b_ct_virtual_seq_h");

  phase.raise_objection(this);
  spi_fd_8b_ct_virtual_seq_h.start(env_h.virtual_seqr_h); //added by the team 3
  phase.drop_objection(this);

endtask:run_phase

`endif
