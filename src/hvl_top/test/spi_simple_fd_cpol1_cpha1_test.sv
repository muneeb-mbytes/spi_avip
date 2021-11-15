`ifndef SPI_SIMPLE_FD_CPOL1_CPHA1_TEST_INCLUDED_
`define SPI_SIMPLE_FD_CPOL1_CPHA1_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_simple_fd_cpol1_cpha1_test
// Description:
// Extended the spi_simple_fd_cpol1_cpha1_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_simple_fd_cpol1_cpha1_test extends base_test;

  //Registering the spi_simple_fd_cpol1_cpha1_test in the factory
  `uvm_component_utils(spi_simple_fd_cpol1_cpha1_test)
  //env_config env_cfg_h;
  // master_agent_config master_agent_cfg_h;
  //slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  // MSHA:m_spi_fd_cpol1_cpha1_seq m_spi_fd_cpol1_cpha1_h;
  // MSHA:s_spi_fd_cpol1_cpha1_seq s_spi_fd_cpol1_cpha1_h;

  spi_fd_cpol1_cpha1_virtual_seq spi_fd_cpol1_cpha1_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_simple_fd_cpol1_cpha1_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_master_agent_cfg_cpol_cpha();
  extern virtual function void setup_slave_agents_cfg_cpol_cpha();
  extern task run_phase(uvm_phase phase);

endclass : spi_simple_fd_cpol1_cpha1_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_simple_fd_cpol1_cpha1_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_simple_fd_cpol1_cpha1_test::new(string name = "spi_simple_fd_cpol1_cpha1_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_simple_fd_cpol1_cpha1_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //env_cfg_h=env_config::type_id::create("env_cfg_h");
  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
  setup_master_agent_cfg_cpol_cpha();
  foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
  env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("slave_agent_cfg_h[%0d]",i));
  end

  setup_slave_agents_cfg_cpol_cpha();
endfunction : build_phase

function void spi_simple_fd_cpol1_cpha1_test::setup_master_agent_cfg_cpol_cpha();
  //env_cfg_h.master_agent_cfg_h.shift_dir = shift_direction_e'(MSB_FIRST);
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.spi_mode = operation_modes_e'(CPOL1_CPHA1);
  env_cfg_h.master_agent_cfg_h.print();
endfunction : setup_master_agent_cfg_cpol_cpha


function void spi_simple_fd_cpol1_cpha1_test::setup_slave_agents_cfg_cpol_cpha();
  super.setup_slave_agents_cfg();
  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
    env_cfg_h.slave_agent_cfg_h[i].spi_mode = operation_modes_e'(CPOL1_CPHA1);
    env_cfg_h.slave_agent_cfg_h[i].print();
  end
  //foreach(env_cfg_h.slave_agent_cfg_h[i])begin
  //env_cfg_h.slave_agent_cfg_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
  //end
endfunction: setup_slave_agents_cfg_cpol_cpha

//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_simple_fd_cpol1_cpha1_test::run_phase(uvm_phase phase);
  
  spi_fd_cpol1_cpha1_virtual_seq_h = spi_fd_cpol1_cpha1_virtual_seq::type_id::create("spi_fd_cpol1_cpha1_virtual_seq_h");
  // MSHA:m_spi_fd_cpol1_cpha1_h = m_spi_fd_cpol1_cpha1_seq::type_id::create("m_spi_fd_cpol1_cpha1_h");
  // MSHA:s_spi_fd_cpol1_cpha1_h = s_spi_fd_cpol1_cpha1_seq::type_id::create("s_spi_fd_cpol1_cpha1_h");

  phase.raise_objection(this);
  // MSHA:fork
  // MSHA:    m_spi_fd_cpol1_cpha1_h.start(env_h.v_seqr_h);
  // MSHA:    s_spi_fd_cpol1_cpha1_h.start(env_h.v_seqr_h);
  // MSHA:join
  spi_fd_cpol1_cpha1_virtual_seq_h.start(env_h.virtual_seqr_h); //added by the team 3
  phase.drop_objection(this);

endtask:run_phase

`endif
