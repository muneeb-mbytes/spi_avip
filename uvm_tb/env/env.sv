`ifndef ENV_INCLUDED_
`define ENV_INCLUDED_


//--------------------------------------------------------------------------------------------
// Class: env
// <Description_here>
//--------------------------------------------------------------------------------------------
class env extends uvm_env;
  `uvm_component_utils(env)
// declaring handle env config
// env_config e_cfg;

// declaring handles for master and slave agent top 
//    master_agent magt;
      master_agent ma_h;
//    master_agent mtop; 
//    slave_agent_top stop;

//    declaring handles for master and slave agent config
//    master_agent_config m_cfg;
//    slave_agent_config s_cfg;
//    declaring handles for virtual sequencr and scoreboard
      master_virtual_sequencer m_v_sqr_h;
//    scoreboard sb; 
   
//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
// extern virtual function void connect_phase(uvm_phase phase);
// extern virtual function void end_of_elaboration_phase(uvm_phase phase);
// extern virtual function void start_of_simulation_phase(uvm_phase phase);
// extern virtual task run_phase(uvm_phase phase);

endclass : env
//--------------------------------------------------------------------------------------------
   function env::new(string name = "env",uvm_component parent = null);
    super.new(name, parent);
   endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
   function void env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    // if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    //  begin
    //  `uvm_fatal("CONFIG", "cannot get() e_cfg from uvm_config")
    //  end
    //creating master agent top and slave agent top
    //  if(e_cfg.has_mtop == 1)begin
         ma_h=master_agent::type_id::create("master_agent",this);
        m_v_sqr_h=master_virtual_sequencer::type_id::create("master_virtual_sequencer",this);
    // end

    //if(e_cfg.has_stop == 1)begin
    //stop = slave_agent_top::type_id::create("stop",this);
    //   end 
    //creating virtual sequencer and scoreboard
    // if(e_cfg.has_master_virtual_sequencer==1)begin
    // v_sequencer = master_virtual_sequencer::type_id::create("v_sequencer",this);
    // end
/* if(e_cfg.has_scoreboard == 1)begin
   sb = scoreboard::type_id::create("sb",this);
   end*/

      endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void env::connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
   if(e_cfg.has_master_virtual_sequencer)
   begin
   if(e_cfg.has_mtop==1) 
   begin
   v_sequencer.m_seqr = mtop.m_agt.m_seqrh;
// mtop.m_agt[i].m_mon.monitor_port.connect(sb.mfifo[i].analysis_export);
// end
// if(e_cfg.has_stop==1) 
// begin
// for(int i=0; i<e_cfg.no_of_sagent; i++)
// begin
// stop.s_agt[i].s_mon.monitor_port.connect(sb.sfifo[i].analysis_export);
// v_sequencer.s_seqr = stop.s_agt[i].s_seqrh;
// end
// end*/
 /*  if(e_cfg.has_scoreboard)
   begin
   mtop.m_agt.monitor_port.connect(sb.analysis_export);
   end*/
//endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void env::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void env::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task env::run_phase(uvm_phase phase);

  phase.raise_objection(this, "env");

  super.run_phase(phase);

  // Work here
  // ...

  phase.drop_objection(this);

endtask : run_phase
*/
`endif

