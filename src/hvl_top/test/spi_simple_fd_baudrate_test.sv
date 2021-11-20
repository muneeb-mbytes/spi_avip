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
  //env_config env_cfg_h;
  // master_agent_config master_agent_cfg_h;
  //slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
//  spi_simple_fd_baudrate_virtual_seq spi_simple_fd_baudrate_virtual_seq_h;

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
// Function:build_phase
//--------------------------------------------------------------------------------------------
//function void spi_simple_fd_baudrate_test::build_phase(uvm_phase phase);
//  super.build_phase(phase);
//
// // env_cfg_h.master_agent_cfg_h.c2tdelay = 1;
//  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
//  setup_master_agent_cfg_c2t();
//  //foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
//   //env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("salve_agent_cfg_h[%0d]",i));
// //end
//
//endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_baudrate_test::setup_master_agent_cfg();
  super.setup_master_agent_cfg();
 // env_cfg_h.master_agent_cfg_h.baudrate_divisor = 4;
//  env_cfg_h.master_agent_cfg_h.print();
  env_cfg_h.master_agent_cfg_h.set_baudrate_divisor(.primary_prescalar(1), .secondary_prescalar(2));
endfunction : setup_master_agent_cfg


//function void spi_simple_fd_baudrate_test::setup_slave_agents_cfg_c2t();
//  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
//  env_cfg_h.slave_agent_cfg_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
//  end
//endfunction: setup_slave_agents_cfg_msb

`endif
