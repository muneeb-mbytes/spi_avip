`ifndef SPI_SIMPLE_FD_8B_TEST_INCLUDED_
`define SPI_SIMPLE_FD_8B_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_8b_test
// Description:
// Extended the spi_simple_fd_8b_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_8b_test extends base_test;

  //Registering the spi_simple_fd_8b_test in the factory
  `uvm_component_utils(spi_simple_fd_8b_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  vseq1_fd_8b_seq vseq1_fd_8b_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_8b_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : spi_simple_fd_8b_test


//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_8b_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_8b_test::new(string name = "spi_simple_fd_8b_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_8b_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_simple_fd_8b_test::run_phase(uvm_phase phase);
  vseq1_fd_8b_h = vseq1_fd_8b_seq::type_id::create("vseq1_fd_8b_h");

  phase.raise_objection(this);

  vseq1_fd_8b_h.start(env_h.vseqr);

  phase.drop_objection(this);

endtask : run_phase

`endif
