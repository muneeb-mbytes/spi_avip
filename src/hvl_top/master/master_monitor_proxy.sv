`ifndef MASTER_MONITOR_PROXY_INCLUDED_
`define MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_monitor_proxy
// <Description of the class
//Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
//A monitor is a passive entity that samples the DUT signals through virtual interface and 
//converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
//Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class master_monitor_proxy extends uvm_component;
  
      //Parameter : Data length
      //Data length of Data_MOSI
      parameter DATA_LENGTH = 8;
  
      `uvm_component_utils(master_monitor_proxy)
  

      //Declaring Virtual Monitor BFM Handle
       virtual master_monitor_bfm m_mon_bfm_h;
      
      //Signal : MOSI Data-Input
      bit [DATA_LENGTH-1:0]data_miso;
      
      //Queue : data_mosi_q
      //Sets of Data_mosi data
       bit [DATA_LENGTH-1:0]data_miso_q[$];
   
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task read_from_mon_bfm(bit CPOL,bit CPHA,bit miso);
  extern virtual task write(bit [DATA_LENGTH-1:0]data);

endclass : master_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_monitor_proxy::new(string name = "master_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual master_monitor_bfm)::get(this,"","m_mon_bfm_h",m_mon_bfm_h)) begin
      `uvm_fatal("FATAL_SMP_MON_BFM",$formatf("Couldn't get S_MON_BFM in Master_Monitor_proxy"));
       end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_monitor_proxy::run_phase(uvm_phase phase);
     `uvm_info(get_type_name(), $sformatf("Inside the master_monitor_proxy"), UVM_LOW)
          repeat(1) begin
           
         // variable : CPOL
         // Clock Polarity 
          bit CPOL=0;
 
          //Signal : CPHA
          //Clock Phase
           bit CPHA=0;
                       
           //Signal : Miso
           //Master-in slave-Out
          // bit mosi;
          //Signal : Mosi
          //Master-out slave-in
          bit miso;
                 
          //Signal : CS
          //Chip Select
          //bit cs;
                                 
  //-------------------------------------------------------
  // Calling the tasks from monitor bfm
 //-------------------------------------------------------
        read_from_mon_bfm(CPOL,CPHA,miso);    
        end
         
          endtask : run_phase 
  //-------------------------------------------------------
  // Task : Mon_bfm
  // Used to call the tasks from moitor bfm
  //-------------------------------------------------------
    task master_monitor_proxy::read_from_mon_bfm(bit CPOL,bit CPHA,bit miso);
     
      case({CPOL,CPHA})
     2'b00 : begin 
              m_mon_bfm_h.sample_miso_pos_00(miso);
              //Converting to transactions
              write(m_mon_bfm_h.data_miso);
              end
     2'b01 : begin 
             m_mon_bfm_h.sample_miso_neg_01(miso);
             write(m_mon_bfm_h.data_miso);
             end
     2'b10 : begin                  
             m_mon_bfm_h.sample_miso_pos_10(miso);
             write(m_mon_bfm_h.data_miso);
             end
     2'b11 : begin
             m_mon_bfm_h.sample_miso_neg_11(miso);
             write(m_mon_bfm_h.data_miso);
             end
           endcase
        
      endtask : read_from_mon_bfm
    
    //-------------------------------------------------------
    // Function : Convert to Transaction class
    // Converts the variables to transaction objects
    //-------------------------------------------------------

 task master_monitor_proxy::write(bit [DATA_LENGTH-1:0]data);

     data_miso = data;
       $display("WRITE__data_miso=%0d",data_miso);
         data_miso_q.push_front(data_miso);
             foreach(data_miso_q[i])
             begin
             $display(data_miso_q[i]);
             end
          
            endtask
  
  
  
  `endif

