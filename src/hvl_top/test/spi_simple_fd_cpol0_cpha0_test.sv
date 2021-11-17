`ifndef SPI_SIMPLE_FD_CPOL0_CPHA0_TEST_INCLUDED_
`define SPI_SIMPLE_FD_CPOL0_CPHA0_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_cpol0_cpha0_test
// Description:
// Extended the spi_simple_fd_cpol0_cpha0_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_cpol0_cpha0_test extends spi_simple_fd_8b_test;

  //Registering the spi_simple_fd_cpol0_cpha0_test in the factory
  `uvm_component_utils(spi_simple_fd_cpol0_cpha0_test)
  //env_config env_cfg_h;
  // master_agent_config master_agent_cfg_h;
  //slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  // MSHA:m_spi_fd_cpol0_cpha0_seq m_spi_fd_cpol0_cpha0_h;
  // MSHA:s_spi_fd_cpol0_cpha0_seq s_spi_fd_cpol0_cpha0_h;

  //spi_fd_cpol0_cpha0_virtual_seq spi_fd_cpol0_cpha0_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_cpol0_cpha0_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agents_cfg();

endclass : spi_simple_fd_cpol0_cpha0_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_cpol0_cpha0_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_cpol0_cpha0_test::new(string name = "spi_simple_fd_cpol0_cpha0_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
//function void spi_simple_fd_cpol0_cpha0_test::build_phase(uvm_phase phase);
//  super.build_phase(phase);
//  //env_cfg_h=env_config::type_id::create("env_cfg_h");
//  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
//  setup_master_agent_cfg_cpol_cpha();
//  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
//  env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("slave_agent_cfg_h[%0d]",i));
//  end
//
//  setup_slave_agents_cfg_cpol_cpha();
//  //env_cfg_h.master_agent_cfg_h.spi_mode = operation_modes_e'(CPOL0_CPHA0);
//  //foreach(env_cfg_h.slave_agent_cfg_h[i])begin
//  //  env_cfg_h.slave_agent_cfg_h[i].spi_mode = operation_modes_e'(CPOL0_CPHA0);
//  //end
//endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_cpol0_cpha0_test::setup_master_agent_cfg();
  //env_cfg_h.master_agent_cfg_h.shift_dir = shift_direction_e'(MSB_FIRST);
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.spi_mode = operation_modes_e'(CPOL0_CPHA0);
  //env_cfg_h.master_agent_cfg_h.print();
endfunction : setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_cpol0_cpha0_test::setup_slave_agents_cfg();
  super.setup_slave_agents_cfg();
  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
    env_cfg_h.slave_agent_cfg_h[i].spi_mode = operation_modes_e'(CPOL0_CPHA0);
    //env_cfg_h.slave_agent_cfg_h[i].print();
  end
  //  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
  //  env_cfg_h.slave_agent_cfg_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
  //  end
endfunction: setup_slave_agents_cfg

`endif
