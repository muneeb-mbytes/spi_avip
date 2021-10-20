`ifndef BASE_TEST_INCLUDED_
`define BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: base_test
// Description:
//  Base test has the test scenarios for testbench which has the env, config, etc.
//  Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

    virtual spi_if vif;
   //-------------------------------------------------------
   // Declaring env config handle
   //-------------------------------------------------------
   env_config e_cfg_h;

   //-------------------------------------------------------
   // Declaring Agent Config Handles
   //-------------------------------------------------------
   slave_agent_config sa_cfg_h[];

   //-------------------------------------------------------
   // Assigning values
   //-------------------------------------------------------
   int no_of_sagent = 1;

   //-------------------------------------------------------
   // Environment Handles
   //-------------------------------------------------------
   env env_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);

endclass : base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes class object
//
// Parameters:
//  name - base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function base_test::new(string name = "base_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Create required ports
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  e_cfg_h = env_config::type_id::create("e_cfg_h");
  e_cfg_h.sa_cfg_h = new[no_of_sagent];
  env_h = env::type_id::create("env",this);

  sa_cfg_h = new[no_of_sagent];
  foreach(sa_cfg_h[i]) begin
    sa_cfg_h[i]=slave_agent_config::type_id::create($sformatf("sa_cfg_h[%0d]",i));
    $display("Agent-%0d",i);
    if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif)) begin
      `uvm_fatal("TEST","COULDNT GET")
      e_cfg_h.sa_cfg_h[i]=sa_cfg_h[i];
    end
  end

  uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg_h);

endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

`endif

//--------------------------------------------------------------------------------------------
//starting spi_fd_8b_test  
//
//--------------------------------------------------------------------------------------------

`ifndef spi_fd_8b_test 
`define spi_fd_8b_test 

//--------------------------------------------------------------------------------------------
//class spi_fd_8b_test:
//Descripition: creating spi_fd_8b_test by extending from base_test
//and declaring handle for master and slave sequence
//
//--------------------------------------------------------------------------------------------

class spi_fd_8b_test extends base_test;
  
 `uvm_component_utils(spi_fd_8b_test)
  m_spi_fd_8b_seq  m_spi_fd_8b;
  s_spi_fd_8b_seq  s_spi_fd_8b;

  //--------------------------------------------------------------------------------------------
  // Externally defined tasks and functions
  //--------------------------------------------------------------------------------------------

  extern function new(string name = "spi_fd_8b_test ", uvm_component parent); 
  extern function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass:spi_fd_8b_test 

//--------------------------------------------------------------------------------------------
//constructor :new
//initializes the spi_fd_8b_test object
//Parameters:
//name   - instance name of the spi_fd_8b_test:
//parent - parent under which this component is created
//
//--------------------------------------------------------------------------------------------

 function spi_fd_8b_test::new(string name = "spi_fd_8b_test ", uvm_component parent);
   super.new(name,parent); 
 endfunction:new

//-----------------------------------------------------------------------------
//Function: build_phase
//Parameters:
//phase - stores the current phase 
//-----------------------------------------------------------------------------
 function void spi_fd_8b_test:: build_phase(uvm_phase phase);
   super.build_phase(phase);
 endfunction:build_phase

 //function void end_of_elaboration_phase(uvm_phase phase);
 //`uvm_info(get_type_name(), $psprintf("SPI VIP hierarchy is %s", this.sprint(printer)), UVM_NONE);
 //endfunction: end_of_elaboration_phase


//-----------------------------------------------------------------------------
//Task: run_phase
//Starts master sequence on master sequencer and slave sequece on slave sequecer
//
//Parameters:
//phase - stores the current phase 
//-----------------------------------------------------------------------------

task spi_fd_8b_test::run_phase(uvm_phase phase);
  m_spi_fd_8b=m_spi_fd_8b_seq::type_id::create("m_spi_fd_8b");
  s_spi_fd_8b=s_spi_fd_8b_seq::type_id::create("s_spi_fd_8b");
   phase.raise_objection(this);
   fork
   m_spi_fd_8b.start(env_h.ma_h.m_sqr_h);
   s_spi_fd_8b.start(env_h.sa_h.s_sqr_h);
   join  
   phase.drop_objection(this);
endtask: run_phase

`endif
    
        
