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
<<<<<<< HEAD
=======
   master_agent_config ma_cfg_h[];
   
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
   slave_agent_config sa_cfg_h[];

   //-------------------------------------------------------
   // Assigning values
   //-------------------------------------------------------
<<<<<<< HEAD
=======
   int no_of_magent = 1;
   
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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
<<<<<<< HEAD
  e_cfg_h.sa_cfg_h = new[no_of_sagent];
  
  sa_cfg_h = new[no_of_sagent];
  foreach(sa_cfg_h[i]) begin
    sa_cfg_h[i]=slave_agent_config::type_id::create($sformatf("sa_cfg_h[%0d]",i));
    //Below line is used to switch between passive and active agents
    //sa_cfg_h[i].is_active = UVM_PASSIVE;
    e_cfg_h.sa_cfg_h[i]=sa_cfg_h[i];
    uvm_config_db #(slave_agent_config)::set(this,"*","slave_agent_config",e_cfg_h.sa_cfg_h[i]);
    if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif)) begin
      `uvm_fatal("TEST","COULDNT GET");
    end
  end
  env_h = env::type_id::create("env",this);
=======
  e_cfg_h.ma_cfg_h = new[no_of_magent];
  e_cfg_h.sa_cfg_h = new[no_of_sagent];
  env_h = env::type_id::create("env",this);
  

  ma_cfg_h = new[no_of_magent];
  foreach(ma_cfg_h[i])
  begin
    ma_cfg_h[i]=master_agent_config::type_id::create($sformatf("ma_cfg_h[%0d]",i));
    $display("Agent-%0d",i);
    if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif))
    begin
      `uvm_fatal("TEST","COULDNT GET")
      e_cfg_h.ma_cfg_h[i]=ma_cfg_h[i];
    end
  end


  sa_cfg_h = new[no_of_sagent];
  foreach(sa_cfg_h[i]) begin
    sa_cfg_h[i]=slave_agent_config::type_id::create($sformatf("sa_cfg_h[%0d]",i));
    $display("Agent-%0d",i);
    if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif)) begin
      `uvm_fatal("TEST","COULDNT GET")
      e_cfg_h.sa_cfg_h[i]=sa_cfg_h[i];
    end
  end

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg_h);

endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

`endif

