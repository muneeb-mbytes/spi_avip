`ifndef SPI_QUAD_SPI_TYPE_TEST_INCLUDED_
`define SPI_QUAD_SPI_TYPE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_quad_spi_type_delay_test
// Description:
// Extended the spi_quad_spi_type_delay_test class from spi_simple_fd_8b_test class
//--------------------------------------------------------------------------------------------
class spi_quad_spi_type_test extends spi_simple_fd_8b_test;

  //Registering the spi_quad_spi_type_delay_test in the factory
  `uvm_component_utils(spi_quad_spi_type_test)
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_quad_spi_type_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agents_cfg();
endclass : spi_quad_spi_type_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_quad_spi_type_delay_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_quad_spi_type_test::new(string name = "spi_quad_spi_type_test",uvm_component parent);
  super.new(name, parent);
endfunction : new


//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_quad_spi_type_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.spi_type =spi_type_e'(QUAD_SPI);
endfunction : setup_master_agent_cfg


function void spi_quad_spi_type_test::setup_slave_agents_cfg();
  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
    env_cfg_h.slave_agent_cfg_h[i].spi_type = spi_type_e'(QUAD_SPI);
  end
endfunction: setup_slave_agents_cfg

`endif
