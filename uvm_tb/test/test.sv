`ifdef BASE_TEST_INCLUDED_
`define BASE_TEST_INCLUDED_

----------------------------------------------------------------------
// Class: test
/ /*User-defined test is derived from uvm_test, uvm_test is inherited from uvm_component.
  Test defines the test scenario for the testbench,test class connvironment,  configuration properties, class overrides etc.
      A sequence/sequences are created and started in the test*/
//-----------------------------------------------------------------------------
      class base_test extends uvm_test;

        `uvm_component_utils(base_test)
          
//            env envh;
//              env_config e_cfg;
 //               master_agent_config m_cfg[];
   //              slave_agent_config s_cfg[];

//---------------------------------------------
 // Externally defined tasks and functions
//---------------------------------------------
       extern function new(string name = "base_test", uvm_component parent); 
     //    extern function void configuration();
         extern function void build_phase(uvm_phase phase);
       endclass:base_test 

 //-----------------------------------------------------------------------------
 // Constructor: new
 // Initializes the config_template class object
 //-----------------------------------------------------------------------------
       function base_test::new(string name = "base_test", uvm_component parent); 
         super.new(name,parent);
       endfunction: new 
//-----------------------------------------------------------------------------
 // Function: config
 // Creates the required ports
 //-----------------------------------------------------------------------------
    /*   function void base_test::configuration();
                                            
          uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
            
         if(has_m_agt)
          begin
                                                          
          m_cfg = new[no_of_magent];
         foreach(m_cfg[i])
           begin
        m_cfg[i] = master_agent_config::type_id::create($sformatf("m_cfg[%0d]",i));
           end
         end
  */
   //-------------------------------------------------------------------  
   // Function: build_phase
 // Creates the required ports
                                                                                                                                                                
   // Parameters:
   //  phase - stores the current phase
   //-----------------------------------------------------------------------------
       function void base_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
           
            /* e_cfg = env_config::type_id::create("e_cfg")
                if(has_m_agt)
               e_cfg.m_cfg = new[no_of_magent];
               configuration();
            uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg)
            super.build()
         */ //  envh=env::type_id::create("env", this);
          endfunction
  //--------------------------------------------------------------------------------------
        `endif
