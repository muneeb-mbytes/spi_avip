`ifndef SPI_SIMPLE_FD_BAUDRATE_TEST_INCLUDED_
`define SPI_SIMPLE_FD_BAUDRATE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_baudrate_test
// Description:
// Extended the spi_simple_fd_baudrate_test class from spi_simple_fd_8b_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_baudrate_test extends spi_simple_fd_8b_test;

  //Registering the spi_simple_fd_baudrate_test in the factory
  `uvm_component_utils(spi_simple_fd_baudrate_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_baudrate_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();

endclass : spi_simple_fd_baudrate_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_baudrate_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_baudrate_test::new(string name = "spi_simple_fd_baudrate_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_baudrate_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.set_baudrate_divisor(.primary_prescalar(1), .secondary_prescalar(2)); 
endfunction : setup_master_agent_cfg


`endif
