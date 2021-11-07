`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;
  
  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
//  import spi_globals_pkg::*;

  `uvm_component_utils(slave_monitor_proxy)
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(slave_tx) slave_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm slave_mon_bfm_h;
    
  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  //extern virtual task read_from_bfm(spi_transfer_char_s packet);
  extern virtual function void reset_detected();
  extern virtual task read(spi_transfer_char_s data_packet);

endclass : slave_monitor_proxy
                                                          
//--------------------------------------------------------------------------------------------
//  Construct: new
//  Parameters:
//  name - slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",uvm_component parent = null);
  super.new(name, parent);

 slave_analysis_port = new("slave_analysis_port",this);

endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",slave_mon_bfm_h)) begin
     `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in Slave_Monitor_proxy"));  
  end 
  //slave_analysis_port = new("slave_analysis_port",this);

  // MSHA: if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",slave_agent_cfg_h)) begin
  // MSHA:   `uvm_fatal("FATAL_S_AGENT_CFG",$sformatf("Couldn't get S_AGENT_CFG in Slave_Monitor_proxy"));
  // MSHA: end

endfunction : build_phase


//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*function void slave_monitor_proxy::connect_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",slave_mon_bfm_h)) begin
     `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get SLAVE_MON_BFM in Slave_Monitor_proxy"));  
   end 
  //slave_analysis_port = new("slave_analysis_port",this);
  
endfunction : connect_phase
*/
//--------------------------------------------------------------------------------------------
//  Task: run_phase
//  Calls tasks defined in Slave_Monitor_BFM 
//--------------------------------------------------------------------------------------------
//task slave_monitor_proxy::run_phase(uvm_phase phase);
//  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW)
//  
////  Will be using this when transaction object in connected
////  forever begin 
//
////  end
//  
//  repeat(1) begin
//    
//    //Variable : CPOL
//    //Clock Polarity 
//    bit CPOL=0;
//    
//    //Signal : CPHA
//    //Clock Phase
//    bit CPHA=0;
//    
//    //Signal : Mosi
//    //Master-in Slave-Out
////    bit mosi;
//
//    //Signal : Miso
//    //Master-in Slave-out
//    bit miso;
//    
//    //Signal : CS
//    //Chip Select
////    bit cs;
//    
//    //-------------------------------------------------------
//    // Calling the tasks from monitor bfm
//    //-------------------------------------------------------
//    read_from_mon_bfm(CPOL,CPHA,mosi);    
//  end
//
//endtask : run_phase 
//
//
////:browse confirm wa
////-------------------------------------------------------
//// Task : read_from_mon_bfm
//// Used to call the tasks from moitor bfm
////-------------------------------------------------------
//task slave_monitor_proxy::read_from_mon_bfm(bit CPOL,bit CPHA,bit mosi);
//    case({CPOL,CPHA})
//      2'b00 : begin
//                  slave_mon_bfm_h.sample_mosi_pos_00(mosi);
//                  //$display("data_mosi=%d",slave_mon_bfm_h.data_mosi);
//                  `uvm_info("data_mosi=%d",slave_mon_bfm_h.data_mosi);
//                  write(slave_mon_bfm_h.data_mosi);
//              end
//      2'b01 : begin 
//                  slave_mon_bfm_h.sample_mosi_neg_01(mosi);
//                  write(slave_mon_bfm_h.data_mosi);
//              end
//      2'b10 : begin                  
//                  slave_mon_bfm_h.sample_mosi_pos_10(mosi);
//                  write(slave_mon_bfm_h.data_mosi);
//              end
//      2'b11 : begin
//                  slave_mon_bfm_h.sample_mosi_neg_11(mosi);
//                 write(slave_mon_bfm_h.data_mosi);
//  end
//    endcase
//endtask : read_from_mon_bfm
////
//////-------------------------------------------------------
////// Task : Write
////// Captures the 8 bit MOSI data sampled.
//////-------------------------------------------------------
//task slave_monitor_proxy::write(bit [DATA_WIDTH-1:0]data);
//
//  data_mosi = data;
//  $display("WRITE__data_mosi=%0d",data_mosi);
//  `uvm_info("WRITE__data_mosi=%0d",data_mosi);
//  data_mosi_q.push_front(data_mosi);
//  ap.write(data_mosi_q);
//  foreach(data_mosi_q[i])
//  begin
//    $display(data_mosi_q[i]);
//    `uvm_info(data_mosi_q[i]);
//  end
//endtask
//
//-------------------------------------------------------------------------------------------
// Function : End of Elobaration Phase
// Used to connect the slave_monitor_proxy defined in slave_monitor_bfm
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  slave_mon_bfm_h.slave_monitor_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: read_from_bfm
// This task receieves the data_packet from slave_monitor_bfm 
// and converts into the transaction object
//--------------------------------------------------------------------------------------------
//task slave_monitor_proxy::read_from_bfm(spi_transfer_char_s packet);
//
//  // TODO(mshariff): Have a way to print the struct values
//  // slave_spi_seq_item_converter::display_struct(packet);
//  // string s;
//  // s = slave_spi_seq_item_converter::display_struct(packet);
//  // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);
//
//  case ({slave_agent_cfg_h.spi_mode, slave_agent_cfg_h.shift_dir})
//
//    {CPOL0_CPHA0,MSB_FIRST}: slave_mon_bfm_h.drive_the_miso_data();
//
//  endcase
//
//endtask: read_from_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);

  // TODO(mshariff): 
  // Clear the data queues and kill the required threads
endfunction: reset_detected


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in Slave_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);
  //`uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW);
  
  bit cpol,cpha;
  // TODO(mshariff): Decide one among this
  // $cast(cpol_cpha, slave_agent_cfg_h.spi_mode);
  {cpol,cpha} = operation_modes_e'(slave_agent_cfg_h.spi_mode);

  // Wait for system reset
  slave_mon_bfm_h.wait_for_reset();

  // Drive the IDLE state for SPI interface
  //slave_mon_bfm_h.drive_idle_state(cpol);

    // Sampling logic
  forever begin
    spi_transfer_char_s struct_packet;
    spi_transfer_cfg_s struct_cfg;
    // Wait for IDLE state on SPI interface
    slave_mon_bfm_h.wait_for_idle_state();

    // MSHA:1010_1011 (AB)

    // MSHA:LSB first - 1 1 0 1 0 1 0 1 
    // MSHA:MSB FIrts - 1 0 1 0 1 0 1 1
    // MSHA:
    // MSHA:req.mosi_data = AB;

    // MSHA:converting to struct 

    // MSHA:bit[no_of_bits_transfer-1:0] mosi_s;

    // MSHA:if(MSB_FIRST)
    // MSHA:  D5
    // MSHA:  mosi_s = flip_version_of(req.mosi_data);

    // MSHA:// LSB First
    // MSHA:for(int i=0; i< no_of_mosi_bits_transfer; i++) begin
    // MSHA:  mosi_dat[i]
    // MSHA:end
    case ({slave_agent_cfg_h.spi_mode, slave_agent_cfg_h.shift_dir})
      {CPOL0_CPHA0,MSB_FIRST}: slave_mon_bfm_h.sample_msb_first_pos_edge(struct_packet,struct_cfg);
    endcase
    //slave_spi_seq_item_converter::to_class(struc_packet, ); 

  end

  
  
  // MSHA: `uvm_info(get_type_name(), $sformatf("SPI Mode is = %b",slave_agent_cfg_h.spi_mode), UVM_LOW)
  //case(slave_agent_cfg_h.spi_mode)
  //  2'b00 : forever begin slave_mon_bfm_h.sample_cpol_0_cpha_0(); end
  //  2'b01 : forever begin slave_mon_bfm_h.sample_cpol_0_cpha_1(); end
  //  2'b10 : forever begin slave_mon_bfm_h.sample_cpol_1_cpha_0(); end
  //  2'b11 : forever begin slave_mon_bfm_h.sample_cpol_1_cpha_1(); end
  //endcase

 // case(slave_agent_cfg_h.spi_mode)
 //   2'b00 : repeat(1) begin slave_mon_bfm_h.sample_cpol_0_cpha_0(); end
 //   2'b01 : repeat(1) begin slave_mon_bfm_h.sample_cpol_0_cpha_0(); end 
 //   2'b10 : repeat(1) begin slave_mon_bfm_h.sample_cpol_0_cpha_0(); end
 //   2'b11 : repeat(1) begin slave_mon_bfm_h.sample_cpol_0_cpha_0(); end
 // endcase

endtask : run_phase 


//-------------------------------------------------------
// Task : Read
// Captures the MOSI and MISO data sampled.
//-------------------------------------------------------
//task slave_monitor_proxy::read(bit [DATA_WIDTH-1:0]data_mosi,
//                               bit [DATA_WIDTH-1:0]data_miso,
//                               bit [DATA_WIDTH-1:0]count);
task slave_monitor_proxy::read(spi_transfer_char_s data_packet);
  
 // if(count >= DATA_WIDTH && count >= DATA_WIDTH ) begin
 //   `uvm_info(get_type_name(), $sformatf("MOSI is = %d",data_mosi), UVM_LOW);
 //   `uvm_info(get_type_name(), $sformatf("MISO is = %d",data_miso), UVM_LOW);     
 // end
 // else begin
 //   `uvm_error(get_type_name(),"Either MOSI data or MISO data is less than the charachter length mentioned");
 // end
 

  //slave_tx slave_tx_h;
  //slave_tx_h = slave_tx::type_id::create("slave_tx_h");
  slave_spi_seq_item_converter slave_spi_seq_item_conv_h;
  //slave_spi_seq_item_conv_h = slave_spi_seq_item_converter::type_id::create("slave_spi_seq_item_conv_h");
  //slave_spi_seq_item_conv_h.to_class(slave_tx_h,data_packet);
  //ap.write(slave_tx_h);
                            
endtask : read

`endif
