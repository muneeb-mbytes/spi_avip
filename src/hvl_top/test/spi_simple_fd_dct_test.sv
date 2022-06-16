`ifndef SPI_SIMPLE_FD_DCT_TEST_INCLUDED_
`define SPI_SIMPLE_FD_DCT_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_8b_dct_test
// Description:
// Extended the spi_simple_fd_8b_dct_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_dct_test extends base_test;

  //Registering the spi_simple_fd_dct_test in the factory
  `uvm_component_utils(spi_simple_fd_dct_test)

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  spi_fd_8b_virtual_seq spi_simple_fd_8b_virtual_seq_h;
  spi_fd_16b_virtual_seq spi_simple_fd_16b_virtual_seq_h;
  spi_fd_32b_virtual_seq spi_simple_fd_32b_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_dct_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase); 
  extern virtual function void setup_master_agent_cfg();
endclass : spi_simple_fd_dct_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_8b_dct_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_dct_test::new(string name = "spi_simple_fd_dct_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//Function: setup_master_agent_cfg
//Setup the master agent configuration with the required values
//and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_dct_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.wdelay= 4;
endfunction : setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_dct_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_simple_fd_dct_test::run_phase(uvm_phase phase);
  
  spi_simple_fd_8b_virtual_seq_h = spi_fd_8b_virtual_seq::type_id::create("spi_simple_fd_8b_virtual_seq_h");
  spi_simple_fd_16b_virtual_seq_h = spi_fd_16b_virtual_seq::type_id::create("spi_simple_fd_16b_virtual_seq_h");
  spi_simple_fd_32b_virtual_seq_h = spi_fd_32b_virtual_seq::type_id::create("spi_simple_fd_32b_virtual_seq_h");

  phase.raise_objection(this);
  spi_simple_fd_8b_virtual_seq_h.start(env_h.virtual_seqr_h); 
  spi_simple_fd_16b_virtual_seq_h.start(env_h.virtual_seqr_h); 
  spi_simple_fd_32b_virtual_seq_h.start(env_h.virtual_seqr_h); 
  phase.drop_objection(this);

endtask:run_phase

`endif
