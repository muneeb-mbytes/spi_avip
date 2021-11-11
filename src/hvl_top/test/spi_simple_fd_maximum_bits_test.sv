`ifndef SPI_SIMPLE_FD_MAXIMUM_BITS_TEST_INCLUDED_
`define SPI_SIMPLE_FD_MAXIMUM_BITS_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_maximum_bits_test
// Description:
// Extended the spi_simple_fd_maximum_bits_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_maximum_bits_test extends base_test;

  //Registering the spi_simple_fd_maximum_bits_test in the factory
  `uvm_component_utils(spi_simple_fd_maximum_bits_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  // MSHA:m_spi_fd_maximum_bits_seq m_spi_fd_maximum_bits_h;
  // MSHA:s_spi_fd_maximum_bits_seq s_spi_fd_maximum_bits_h;

  spi_fd_maximum_bits_virtual_seq spi_fd_maximum_bits_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_maximum_bits_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : spi_simple_fd_maximum_bits_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_maximum_bits_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_maximum_bits_test::new(string name = "spi_simple_fd_maximum_bits_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_maximum_bits_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_simple_fd_maximum_bits_test::run_phase(uvm_phase phase);
  
  spi_fd_maximum_bits_virtual_seq_h = spi_fd_maximum_bits_virtual_seq::type_id::create("spi_fd_maximum_bits_virtual_seq_h");
  // MSHA:m_spi_fd_maximum_bits_h = m_spi_fd_maximum_bits_seq::type_id::create("m_spi_fd_maximum_bits_h");
  // MSHA:s_spi_fd_maximum_bits_h = s_spi_fd_maximum_bits_seq::type_id::create("s_spi_fd_maximum_bits_h");

  phase.raise_objection(this);
  // MSHA:fork
  // MSHA:    m_spi_fd_maximum_bits_h.start(env_h.v_seqr_h);
  // MSHA:    s_spi_fd_maximum_bits_h.start(env_h.v_seqr_h);
  // MSHA:join
  spi_fd_maximum_bits_virtual_seq_h.start(env_h.virtual_seqr_h); //added by the team 3
  phase.drop_objection(this);

endtask:run_phase

`endif
