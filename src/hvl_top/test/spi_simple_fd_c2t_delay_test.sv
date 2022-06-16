`ifndef SPI_SIMPLE_FD_C2T_DELAY_TEST_INCLUDED_
`define SPI_SIMPLE_FD_C2T_DELAY_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_c2t_delay_test
// Description:
// Extended the spi_simple_fd_c2t_delay_test class from spi_simple_fd_8b_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_c2t_delay_test extends spi_simple_fd_8b_test;

  //Registering the spi_simple_fd_c2t_delay_test in the factory
  `uvm_component_utils(spi_simple_fd_c2t_delay_test)


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_c2t_delay_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();

endclass : spi_simple_fd_c2t_delay_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_c2t_delay_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_c2t_delay_test::new(string name = "spi_simple_fd_c2t_delay_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_c2t_delay_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.c2tdelay = 2;
endfunction : setup_master_agent_cfg



`endif
