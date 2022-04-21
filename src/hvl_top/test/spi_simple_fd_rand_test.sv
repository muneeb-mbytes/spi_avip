`ifndef SPI_SIMPLE_FD_RAND_TEST_INCLUDED_
`define SPI_SIMPLE_FD_RAND_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_rand_test
// Description:
// Extended the spi_simple_fd_rand_test class from spi_simple_fd_8b_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_rand_test extends spi_simple_fd_8b_test;

  //Registering the spi_simple_fd_rand_test in the factory
  `uvm_component_utils(spi_simple_fd_rand_test)

  env env_h;

  operation_modes_e cfg_mode;
  shift_direction_e shift_dir_test;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_rand_test", uvm_component parent);
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agents_cfg();
endclass : spi_simple_fd_rand_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_rand_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_rand_test::new(string name = "spi_simple_fd_rand_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void spi_simple_fd_rand_test::setup_master_agent_cfg();

  // Configure the Master agent configuration
  super.setup_master_agent_cfg();

  // Using the std randomize trying to sync the master random configs with slave configs
  if(!std::randomize(cfg_mode)) begin
    `uvm_error("test",$sformatf("randomization of cfg failed"))
    end
  if(!std::randomize(shift_dir_test)) begin
    `uvm_error("test",$sformatf("randomization  of dir failed"))
  end

  `uvm_info("master_random_cfg_mode",$sformatf("rand_test_cfg_mode =  \n %0p",cfg_mode),UVM_FULL)
  `uvm_info("master_random_cfg_mode",$sformatf("rand_test_shift_dir =  \n %0p",shift_dir_test),UVM_FULL)

  if(! env_cfg_h.master_agent_cfg_h.randomize() with {this.spi_mode == cfg_mode;
                                                      this.shift_dir == shift_dir_test; 
                                                    }) begin
      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in master test"))
  end
  `uvm_info(get_type_name(),$sformatf("randomize master config data =  \n %0p",
                                       env_cfg_h.master_agent_cfg_h.sprint()),UVM_FULL)
  //env_cfg_h.master_agent_cfg_h.print();

endfunction: setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void spi_simple_fd_rand_test::setup_slave_agents_cfg();
  
  // Configure the Master agent configuration
  super.setup_slave_agents_cfg();
  
  `uvm_info("slave_random_cfg_mode",$sformatf("rand_test_cfg_mode =  \n %0p",cfg_mode),UVM_FULL)
  `uvm_info("slave_random_cfg_mode",$sformatf("rand_test_shift_dir =  \n %0p",shift_dir_test),UVM_FULL)

  // Setting the configuration for each slave
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
    if(! env_cfg_h.slave_agent_cfg_h[i].randomize() with {this.spi_mode == cfg_mode;
                                                      this.shift_dir == shift_dir_test; 
                                                    }) begin
      `uvm_fatal(get_type_name(),$sformatf("Randomization failed in test"))
    end
  end

endfunction: setup_slave_agents_cfg

`endif
