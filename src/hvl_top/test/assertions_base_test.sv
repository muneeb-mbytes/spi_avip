`ifndef ASSERTIONS_BASE_TEST_INCLUDED_
`define ASSERTIONS_BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: base_test
//  Base test has the test scenarios for testbench which has the env, config, etc.
//  Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class assertions_base_test extends base_test;
  `uvm_component_utils(assertions_base_test)
  // Variable: env_cfg_h
  // Declaring environment config handle
  env_config env_cfg_h;

  // Variable: env_h
  // Handle for environment 
  env env_ha;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "assertions_base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
 // extern virtual function void setup_env_cfg();
 // extern virtual function void setup_master_agent_cfg();
//  extern virtual function void setup_slave_agents_cfg();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : assertions_base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes class object
//
// Parameters:
//  name - assertions_base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function assertions_base_test::new(string name = "assertions_base_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Create required ports
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void assertions_base_test::build_phase(uvm_phase phase);
  
  `uvm_info(get_type_name(), $sformatf("BUILD_PHASE assertions_base_test"), UVM_NONE);
   super.build_phase(phase);
  // Setup the environemnt cfg 
  env_cfg_h = env_config::type_id::create("env_cfg_h");
  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
  setup_env_cfg();
  // Create the environment
  env_ha = env::type_id::create("env_ha",this);

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_env_cfg
// Setup the environment configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
/* function void assertions_base_test::setup_env_cfg();
  //env_cfg_h = env_config::type_id::create("env_cfg_h");
  env_cfg_h.no_of_slaves = NO_OF_SLAVES;
  env_cfg_h.has_scoreboard = 1;
  env_cfg_h.has_virtual_seqr = 1;
  
  // Setup the master agent cfg 
  //env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
  setup_master_agent_cfg();
  uvm_config_db #(master_agent_config)::set(this,"*master_agent*","master_agent_config",env_cfg_h.master_agent_cfg_h);
  env_cfg_h.master_agent_cfg_h.print();
  
  // Setup the slave agent(s) cfg 
  env_cfg_h.slave_agent_cfg_h = new[env_cfg_h.no_of_slaves];
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
    env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("slave_agent_cfg_h[%0d]",i));
  end
  setup_slave_agents_cfg();
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
    uvm_config_db #(slave_agent_config)::set(this,$sformatf("*slave_agent_h[%0d]*",i),
                                             "slave_agent_config", env_cfg_h.slave_agent_cfg_h[i]);
   env_cfg_h.slave_agent_cfg_h[i].print();
  end

  // set method for env_cfg
  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);
  env_cfg_h.print();
 endfunction: setup_env_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void assertions_base_test::setup_master_agent_cfg();
  //env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
  // Configure the Master agent configuration
  env_cfg_h.master_agent_cfg_h.is_active            = uvm_active_passive_enum'(UVM_ACTIVE);
  env_cfg_h.master_agent_cfg_h.no_of_slaves         = NO_OF_SLAVES;
  env_cfg_h.master_agent_cfg_h.spi_mode             = operation_modes_e'(CPOL0_CPHA0);
  env_cfg_h.master_agent_cfg_h.shift_dir            = shift_direction_e'(LSB_FIRST);
  env_cfg_h.master_agent_cfg_h.c2tdelay             = 1;
  env_cfg_h.master_agent_cfg_h.t2cdelay             = 1;
  env_cfg_h.master_agent_cfg_h.has_coverage         = 1;

  // baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
  // baudrate = busclock / baudrate_divisor_divisor;
  env_cfg_h.master_agent_cfg_h.set_baudrate_divisor(.primary_prescalar(0), .secondary_prescalar(0));

 // uvm_config_db #(master_agent_config)::set(this,"*master_agent*","master_agent_config",env_cfg_h.master_agent_cfg_h);
 //env_cfg_h.master_agent_cfg_h.print();
endfunction: setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
 function void assertions_base_test::setup_slave_agents_cfg();
  // Create slave agent(s) configurations
  // env_cfg_h.slave_agent_cfg_h = new[env_cfg_h.no_of_slaves];
  // Setting the configuration for each slave
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
    //env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("salve_agent_cfg_h[%0d]",i));
    env_cfg_h.slave_agent_cfg_h[i].slave_id     = i;
    env_cfg_h.slave_agent_cfg_h[i].is_active    = uvm_active_passive_enum'(UVM_ACTIVE);
    env_cfg_h.slave_agent_cfg_h[i].spi_mode     = operation_modes_e'(CPOL0_CPHA0);
    env_cfg_h.slave_agent_cfg_h[i].shift_dir    = shift_direction_e'(LSB_FIRST);
    env_cfg_h.slave_agent_cfg_h[i].has_coverage = 1;

    // MSHAdb #(slave_agent_config)::set(this,"*slave_agent*",
    // MSHA:                                         $sformatf("slave_agent_config[%0d]",i),
    // MSHA:                                         env_cfg_h.salve_agent_cfg_h[i]);

   // uvm_config_db #(slave_agent_config)::set(this,$sformatf("*slave_agent_h[%0d]*",i),
   //                                          "slave_agent_config", env_cfg_h.slave_agent_cfg_h[i]);
   // env_cfg_h.slave_agent_cfg_h[i].print();
  end

endfunction: setup_slave_agents_cfg
*/

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// Used for printing the testbench topology
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void assertions_base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used for giving basic delay for simulation 
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task assertions_base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this, "assertions_base_test");

  `uvm_info(get_type_name(), $sformatf("Inside assertions_base_test"), UVM_NONE);
  super.run_phase(phase);

  // TODO(mshariff): 
  // Need to be replaced with delay task in BFM interface
  // in-order to get rid of time delays in HVL side
  //spi_fd_8b_master_seq_h = spi_fd_8b_master_seq::type_id::create("spi_fd_8b_master_seq_h"); 
  //spi_fd_8b_master_seq_h.start(env_h.master_agent_h.master_seqr_h);
  #1000;
  
  `uvm_info(get_type_name(), $sformatf("Done assertions_base_test"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase

`endif

