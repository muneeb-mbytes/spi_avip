`ifndef SPI_C2T_DELAY_TEST_INCLUDED_
`define SPI_C2T_DELAY_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_c2t_delay_test
// Description:
// Extended the spi_c2t_delay_test class from base_test class
//--------------------------------------------------------------------------------------------
class spi_c2t_delay_test extends base_test;

  //Registering the spi_c2t_delay_test in the factory
  `uvm_component_utils(spi_c2t_delay_test)
  //env_config env_cfg_h;
  // master_agent_config master_agent_cfg_h;
  //slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Declaring sequence handles  
  //-------------------------------------------------------
  spi_c2t_delay_virtual_seq spi_c2t_delay_virtual_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_c2t_delay_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void setup_master_agent_cfg_c2t();
  extern task run_phase(uvm_phase phase);

endclass : spi_c2t_delay_test

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes class object
// Parameters:
// name - spi_c2t_delay_test
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_c2t_delay_test::new(string name = "spi_c2t_delay_test",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function:build_phase
//--------------------------------------------------------------------------------------------
function void spi_c2t_delay_test::build_phase(uvm_phase phase);
  super.build_phase(phase);

 // env_cfg_h.master_agent_cfg_h.c2tdelay = 1;
  env_cfg_h.master_agent_cfg_h = master_agent_config::type_id::create("master_agent_cfg_h");
  setup_master_agent_cfg_c2t();
  //foreach(env_cfg_h.slave_agent_cfg_h[i]) begin
   //env_cfg_h.slave_agent_cfg_h[i] = slave_agent_config::type_id::create($sformatf("salve_agent_cfg_h[%0d]",i));
 //end

endfunction : build_phase

function void spi_c2t_delay_test::setup_master_agent_cfg_c2t();
  super.setup_master_agent_cfg();
  env_cfg_h.master_agent_cfg_h.c2tdelay = 2;
  env_cfg_h.master_agent_cfg_h.print();
endfunction : setup_master_agent_cfg_c2t


//function void spi_c2t_delay_test::setup_slave_agents_cfg_c2t();
//  foreach(env_cfg_h.slave_agent_cfg_h[i])begin
//  env_cfg_h.slave_agent_cfg_h[i].shift_dir = shift_direction_e'(MSB_FIRST);
//  end
//endfunction: setup_slave_agents_cfg_msb


//--------------------------------------------------------------------------------------------
// Task:run_phase
// Responsible for starting the transactions
//--------------------------------------------------------------------------------------------
task spi_c2t_delay_test::run_phase(uvm_phase phase);
  
  spi_c2t_delay_virtual_seq_h =  spi_c2t_delay_virtual_seq::type_id::create("spi_c2t_delay_virtual_seq_h");
  // MSHA:m_spi_fd_msb_lsb_h = m_spi_fd_msb_lsb_seq::type_id::create("m_spi_fd_msb_lsb_h");
  // MSHA:s_spi_fd_msb_lsb_h = s_spi_fd_msb_lsb_seq::type_id::create("s_spi_fd_msb_lsb_h");

  phase.raise_objection(this);
  // MSHA:fork
  // MSHA:    m_spi_fd_msb_lsb_h.start(env_h.v_seqr_h);
  // MSHA:    s_spi_fd_msb_lsb_h.start(env_h.v_seqr_h);
  // MSHA:join
  spi_c2t_delay_virtual_seq_h.start(env_h.virtual_seqr_h); //added by the team 3
  phase.drop_objection(this);

endtask:run_phase

`endif
