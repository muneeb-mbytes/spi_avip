`ifndef SPI_SIMPLE_FD_CROSS_TEST_INCLUDED_
`define SPI_SIMPLE_FD_CROSS_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_cross_test
// Description:
//--------------------------------------------------------------------------------------------
class spi_simple_fd_cross_test extends spi_simple_fd_8b_test;
  `uvm_component_utils(spi_simple_fd_cross_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_cross_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agents_cfg();

endclass : spi_simple_fd_cross_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_cross_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_cross_test::new(string name = "spi_simple_fd_cross_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void spi_simple_fd_cross_test::setup_master_agent_cfg();

  // Configure the Master agent configuration
  super.setup_master_agent_cfg();

  // Modifying ONLY the required fields 
  env_cfg_h.master_agent_cfg_h.spi_mode = operation_modes_e'(CPOL0_CPHA1);
  env_cfg_h.master_agent_cfg_h.shift_dir = shift_direction_e'(MSB_FIRST);
  env_cfg_h.master_agent_cfg_h.set_baudrate_divisor(.primary_prescalar(0), .secondary_prescalar(0));
  env_cfg_h.master_agent_cfg_h.t2cdelay = 2;
  env_cfg_h.master_agent_cfg_h.c2tdelay = 2;
  env_cfg_h.master_agent_cfg_h.wdelay = 2;
  env_cfg_h.master_agent_cfg_h.no_of_slaves = 1;

endfunction: setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void spi_simple_fd_cross_test::setup_slave_agents_cfg();

  // Configure the Master agent configuration
  super.setup_slave_agents_cfg();

  // Setting the configuration for each slave
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
    env_cfg_h.slave_agent_cfg_h[i].spi_mode = operation_modes_e'(CPOL0_CPHA1);
    env_cfg_h.slave_agent_cfg_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
  end

endfunction: setup_slave_agents_cfg

`endif
