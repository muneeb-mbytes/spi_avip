`ifndef MASTER_MONITOR_PROXY_INCLUDED_
`define MASTER_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: master_monitor_proxy
//This is the HVL slave monitor proxy
//It gets the sample data from the HDL slave monitor and converts
//hem into transaction items
//--------------------------------------------------------------------------------------------
class master_monitor_proxy extends uvm_component;

  //parameter : Data length
  //Data length of Data_MOSI
  parameter DATA_LENGTH=8;
  
  `uvm_component_utils(master_monitor_proxy)
  
   virtual spi_if vif;    
   
   //Declaring Virtual Monitor BFM Handle
   virtual master_monitor_bfm m_mon_bfm_h;

   //signal : MOSI Data-Input
   bit [DATA_LENGTH-1:0]data_miso;
//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "master_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task mon_bfm(bit cs,bit CPOL,bit CPHA,bit miso,bit mosi,bit [2:0]txn_values);
  extern virtual function void convert_to_txn(bit [2:0]txn_values,bit [3:0]i);

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
    if(!uvm_config_db#(virtual spi_if)::get(this,"","vif",vif)) begin
      `uvm_fatal("FATAL_SMP_VIF",$formatf("Couldn't get INTF in Master_Monitor_proxy"));
     end
    if(!uvm_config_db#(virtual master_monitor_bfm)::get(this,"","m_mon_bfm_h",m_mon_bfm_h)) begin
      `uvm_fatal("FATAL_SMP_MON_BFM",$formatf("Couldn't get M_MON_BFM_h in Master_Monitor_proxy"));
     end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in Master_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task master_monitor_proxy::run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Inside the master_monitor_proxy"), UVM_LOW);
 
//Will be using this when transaction object in connected
 //forever begin 
  //end

  repeat(1) begin
              
   //Variable : CPOL
   //Clock Polarity 
   bit CPOL=0;
  
   //Signal : CPHA
   //Clock Phase
   bit CPHA=1;
                                         
   //Signal : Mosi
   //Master-in Slave-Out
   bit mosi;
  
   //Signal : Miso
  //Master-in Slave-out
   bit miso;
                                                                     
  //Signal:CS                 
     //Chip Select
     bit cs;
    //Variable : Txn_values
    //Consists of Mosi, Miso Values.
    bit [2:0] txn_values;

//-----------------------------------------------------               
// Calling the tasks from monitor bfm                                         
//-------------------------------------------------------
  mon_bfm(cs,CPOL,CPHA,miso,mosi,txn_values);    
    end

  endtask : run_phase 
  
//-------------------------------------------------------      
// Task : Mon_bfm
// Used to call the tasks from moitor bfm
//-------------------------------------------------------
task master_monitor_proxy::mon_bfm(bit cs,bit CPOL,bit CPHA,bit miso,bit mosi,bit [2:0]txn_values);
  bit [3:0]i;
  if(!cs) begin
  $display("Entering If");
   $display(CPOL,CPHA);                                                              
   case({CPOL,CPHA})
    
   2'b00 :begin
           for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++) 
           m_mon_bfm_h.sample_miso_pos_00(miso,mosi,cs,txn_values);
           //Converting to transactions
           convert_to_txn(m_mon_bfm_h.sample_miso_pos_00.txn_values,i);
          end

   2'b01 : begin 
          // for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
          //begin
         //  bit [3:0]i;
          //delete the below line if yoy remove for loop comments
          $display("Entering 2'b01");
          m_mon_bfm_h.sample_miso_neg_01(miso,mosi,cs,txn_values);
          $display("txn_values=%b",m_mon_bfm_h.sample_miso_pos_01.txn_vaiues);
          //Converting to transactions
          convert_to_txn(m_mon_bfm_h.sample_miso_pos_01.txn_values,i);
          //end
          end
   2'b10 : begin
           for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
           m_mon_bfm_h.sample_miso_pos_10(miso,mosi,cs,txn_values);
           //Converting to transaction
           convert_to_txn(m_mon_bfm_h.sample_miso_pos_10.txn_values,i);
           end
   2'b11 :begin
          for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
          m_mon_bfm_h.sample_miso_neg_11(miso,mosi,cs,txn_values);
         //Converting to transactions
          convert_to_txn(m_mon_bfm_h.sample_miso_neg_11.txn_values,i);
          end
    endcase
  end
 endtask
//------------------------------------------------------
// Function : Convert to Transaction class
// Converts the variables to transaction objects
//---------------------------------------------------
function void master_monitor_proxy::convert_to_txn(bit [2:0]txn_values,bit [3:0]i);
  $display("Inside Convert to Txn Class");
  $display("mosi=%b", txn_values[0]);
  $display("miso=%b", txn_values[1]);
  $display("cs=%b", txn_values[2]);
  
  data_miso[i] = (txn_values[0]);
  //These will be used when transaction class is used
  //txn_h = new();
  //txn_h.cs = cs;
  //txn_h.mosi = mosi;
  //txn_h.miso = miso;
  //txn_h.data_mosi[i] = txn_values[0];
endfunction : convert_to_txn
    `endif
