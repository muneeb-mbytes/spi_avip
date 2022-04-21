`ifndef SPI_SIMPLE_FD_CPOL1_CPHA0_TEST_INCLUDED_
`define SPI_SIMPLE_FD_CPOL1_CPHA0_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_cpol1_cpha0_test
// Description:
// Extended the spi_simple_fd_cpol1_cpha0_test class from spi_simple_fd_8b_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_cpol1_cpha0_test extends spi_simple_fd_8b_test;

  //Registering the spi_simple_fd_cpol1_cpha0_test in the factory
  `uvm_component_utils(spi_simple_fd_cpol1_cpha0_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_cpol1_cpha0_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agents_cfg();

endclass : spi_simple_fd_cpol1_cpha0_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_cpol1_cpha0_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_cpol1_cpha0_test::new(string name = "spi_simple_fd_cpol1_cpha0_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_cpol1_cpha0_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.spi_mode = operation_modes_e'(CPOL1_CPHA0);
endfunction : setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_cpol1_cpha0_test::setup_slave_agents_cfg();
  super.setup_slave_agents_cfg();
  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
    env_cfg_h.slave_agent_cfg_h[i].spi_mode = operation_modes_e'(CPOL1_CPHA0);
  end
endfunction: setup_slave_agents_cfg

`endif
