`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;

  //Parameter : Data length
  //Data length of Data_MOSI
  parameter DATA_LENGTH = 8;

  `uvm_component_utils(slave_monitor_proxy)
  
  //Declaring Virtual Interface Handle
  virtual spi_if vif;
  
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm s_mon_bfm_h;

  //Signal : MOSI Data-Input
  bit [DATA_LENGTH-1:0]data_mosi;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task mon_bfm(bit cs,bit CPOL,bit CPHA,bit miso,bit mosi, bit [2:0]txn_values);
  extern virtual function void convert_to_txn(bit [2:0]txn_values, bit [3:0]i);

endclass : slave_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual spi_if)::get(this,"","vif",vif)) begin
    `uvm_fatal("FATAL_SMP_VIF",$formatf("Couldn't get INTF in Slave_Monitor_proxy"));
  end
  if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","s_mon_bfm_h",s_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$formatf("Couldn't get S_MON_BFM in Slave_Monitor_proxy"));
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in Slave_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW)
  
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
    
    //Signal : CS
    //Chip Select
    bit cs;
    
    //Variable : Txn_values
    //Consists of Mosi, Miso Values.
    //bit [2:0] txn_values;

    //-------------------------------------------------------
    // Calling the tasks from monitor bfm
    //-------------------------------------------------------
    mon_bfm(cs,CPOL,CPHA,mosi,miso,txn_values);    
  end

endtask : run_phase 


//-------------------------------------------------------
// Task : Mon_bfm
// Used to call the tasks from moitor bfm
//-------------------------------------------------------
task slave_monitor_proxy::mon_bfm(bit cs,bit CPOL,bit CPHA,bit miso,bit mosi,bit [2:0]txn_values);
  if(!cs) begin
    $display("Entering If");
    $display(CPOL,CPHA);
    case({CPOL,CPHA})
      2'b00 : for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
                begin 
                  s_mon_bfm_h.sample_mosi_pos_00(mosi,miso,cs,txn_values);
                  //Converting to transactions
                  convert_to_txn(s_mon_bfm_h.sample_mosi_pos_00.txn_values,i);
                end
      2'b01 : begin 
              //for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
                //begin
                //delete the below line if yoy remove for loop comments
                  bit [3:0]i;
                  $display("Entering 2'b01");
                  s_mon_bfm_h.sample_mosi_neg_01(mosi,miso,cs,txn_values);
                  $display("txn_values=%b",s_mon_bfm_h.sample_mosi_neg_01.txn_values);
                  //Converting to transactions
                  convert_to_txn(s_mon_bfm_h.sample_mosi_neg_01.txn_values,i);
                //end
              end
      2'b10 : for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
                begin 
                  s_mon_bfm_h.sample_mosi_pos_10(mosi,miso,cs,txn_values);
                  //Converting to transactions
                  convert_to_txn(s_mon_bfm_h.sample_mosi_pos_10.txn_values,i);
                end
      2'b11 : for(bit [3:0]i=DATA_LENGTH-1;i<=0;i++)
                begin 
                  s_mon_bfm_h.sample_mosi_neg_11(mosi,miso,cs,txn_values);
                  //Converting to transactions
                  convert_to_txn(s_mon_bfm_h.sample_mosi_neg_11.txn_values,i);
                end
    endcase
  end
endtask : mon_bfm


//-------------------------------------------------------
// Function : Convert to Transaction class
// Converts the variables to transaction objects
//-------------------------------------------------------
function void slave_monitor_proxy::convert_to_txn(bit [2:0]txn_values,bit [3:0]i);

  
   $display("Inside Convert to Txn Class");
   $display("mosi=%b", txn_values[0]);
   $display("miso=%b", txn_values[1]);
   $display("cs=%b", txn_values[2]);
   data_mosi[i] = txn_values[0];

   //These will be used when transaction class is used.
   //txn txn_h = new();
   //txn_h.cs = cs;
   //txn_h.mosi = mosi;
   //txn_h.miso = miso;
   //txn_h.data_mosi[i] = txn_values[0];

endfunction : convert_to_txn

`endif
