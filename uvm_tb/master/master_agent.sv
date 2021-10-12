`ifdef _MASTER_AGENT_INCLUDED_
`define _MASTER_AGENT_INCLUDED_


//-----------------------------------------------------------------------------
// Class: master_agent
// Description of the class.
//agent is container called universal verification component
// that contain driver,monitor,sequencer
//
//------------------------------------------------------------------------------
class master_agent extends uvm_agent;

//register with factory so can use create uvm_method 
//and override in future if necessary 

   `uvm_component_utils(master_agent)
  
//declaring handle for master config class,master driver
//master monitor and master sequencer 

    //master_agent_config  m_cfg;
   // master_driver  m_drv;
   // master_monitor  m_mon;
   // master_sequencer m_seqrh;
  
//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
     extern function new(string name = "master_agent", uvm_component parent); 
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     endclass: master_agent
  
//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_agent class component
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
      function master_agent::new(string name="master_agent", uvm_component parent); 
         super.new(name,parent); 
       endfunction: new 
  
 //-----------------------------------------------------------------------------
  //       // Function: build_phase
  //       // Creates the required ports
  //       //
  //       // Parameters:
  //       //  phase - stores the current phase 
  //       //-----------------------------------------------------------------------------
     /* function void master_agent::build_phase(uvm_phase phase);
         super.build_phase(phase);
       if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
          begin
       `uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
          end
  //creating master monitor
      m_mon=master_monitor::type_id::create("m_mon",this);
            m_cfg=new();

//If the master agent is made active in master_configuration
// class create driver and sequence
             if(m_cfg.is_active==UVM_ACTIVE)
               begin
              m_drv=master_driver::type_id::create("m_drv",this);
              m_seqrh=master_sequencer::type_id::create("m_seqrh",this);
               end
    
        endfunction: build_phase
//----------------------------------------------------------------------------------
//Function:connect phase
//connectiong the master driver sequence item port to master sequencer sequence item export
//-----------------------------------------------------------------------------------
         function void master_agent::connect_phase(uvm_phase phase);
           if(m_cfg.is_active==UVM_ACTIVE)
            begin
            m_drv.seq_item_port.connect(m_seqrh.seq_item_export);
            end
         endfunction:connect_phase*/
//------------------------------------------------------------------------------------
     function void master_agent::build_phase(uvm_phase phase);
     super.build_phase(phase);
     endfunction
  `endif
