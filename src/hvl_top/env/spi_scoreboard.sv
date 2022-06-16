`ifndef SPI_SCOREBOARD_INCLUDED_
`define SPI_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_scoreboard
// Scoreboard the data getting from monitor port that goes into the implementation port
//--------------------------------------------------------------------------------------------
class spi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(spi_scoreboard)
  
  //Variable : master_tx_h
  //declaring master transaction handle
  master_tx master_tx_h;
  
  //Variable : slave_tx_h
  //declaring slave transaction handle
  slave_tx slave_tx_h;
  
  //Variable : env_cfg_h
  //declaring env config handle
  env_config env_cfg_h;

  //Variable : master_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(master_tx)master_analysis_fifo;
 
  //Variable : slave_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(slave_tx)slave_analysis_fifo;
  
  //Variable master_tx_count
  //to keep track of number of transaction for master spi
  int master_tx_count = 0;


  //Variable slave_tx_count
  //to keep track of number of transaction for slave spi
  int slave_tx_count = 0;


  //Variable byte_data_cmp_verified_mosi_count
  //to keep track of number of byte wise compared verified mosi data
  int byte_data_cmp_verified_mosi_count = 0;

  //Variable byte_data_cmp_verified_miso_count
  //to keep track of number of byte wise compared verified miso data
  int byte_data_cmp_verified_miso_count = 0;

  //Variable byte_data_cmp_failed_mosi_count
  //to keep track of number of byte wise compared failed mosi data
  int byte_data_cmp_failed_mosi_count = 0;

  //Variable byte_data_cmp_failed_miso_count
  //to keep track of number of byte wise compared failed miso data
  int byte_data_cmp_failed_miso_count = 0;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_scoreboard", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);
endclass : spi_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - spi_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_scoreboard::new(string name = "spi_scoreboard", uvm_component parent = null);
  super.new(name, parent);
  master_analysis_fifo = new("master_analysis_fifo",this);
  slave_analysis_fifo = new("slave_analysis_fifo",this);
endfunction : new



//--------------------------------------------------------------------------------------------
// Task: run_phase
// All the comparision are done
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task spi_scoreboard::run_phase(uvm_phase phase);

 super.run_phase(phase);

 forever begin
 
 `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
 master_analysis_fifo.get(master_tx_h);
 // TODO(mshariff): Keep a track on master transaction
 master_tx_count++;
 
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing master_tx_h, \n %s",master_tx_h.sprint()),UVM_HIGH)

 slave_analysis_fifo .get(slave_tx_h);
 // TODO(mshariff): Keep a track on slave transaction
 slave_tx_count++;
 
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing slave_tx_h, \n %s",slave_tx_h.sprint()),UVM_HIGH)
 
 // MSHA:   Displpay even the SLave id - it must be in the packet 
 
 // MSHA:   // TODO(mshariff): 
 // MSHA:   // Once you get the transcations, do the comparision per byte basis
 // MSHA:   // Master MOSI with Slave MISO and
 // MSHA:   // SLave MISO with Master MOSI
 // MSHA:   // Also, no_of_mosi_bits and no_of_miso_bits
  
  
 
  // Data comparision for MOSI 
  if (master_tx_h.master_out_slave_in.size() == slave_tx_h.master_out_slave_in.size())begin 
   `uvm_info (get_type_name(), $sformatf ("Size of MOSI data from Master and Slave is equal"),UVM_HIGH);
  end
  else begin
   `uvm_error (get_type_name(),$sformatf("Size of MOSI data from Master and Slave is not equal"));
  end

  foreach(master_tx_h.master_out_slave_in[i]) begin
     if(master_tx_h.master_out_slave_in[i] != slave_tx_h.master_out_slave_in[i]) begin
       `uvm_error("ERROR_SC_MOSI_DATA_MISMATCH", 
                 $sformatf("Master MOSI[%0d] = 'h%0x and Slave MOSI[%0d] = 'h%0x", 
                           i, master_tx_h.master_out_slave_in[i],
                           i, slave_tx_h.master_out_slave_in[i]) );
       byte_data_cmp_failed_mosi_count++;
     end
     else begin
       `uvm_info("SB_MOSI_DATA_MATCH", 
                 $sformatf("Master MOSI[%0d] = 'h%0x and Slave MOSI[%0d] = 'h%0x", 
                           i, master_tx_h.master_out_slave_in[i],
                           i, slave_tx_h.master_out_slave_in[i]), UVM_HIGH);
                           
       byte_data_cmp_verified_mosi_count++;
     end
    end   

  // TODO(mshariff): Do a similar work for MISO

   if (slave_tx_h.master_in_slave_out.size() == master_tx_h.master_in_slave_out.size()) begin
      `uvm_info (get_type_name(), $sformatf ("Size of MISO data from Master and Slave is equal"),UVM_HIGH);
    end
   else begin
      `uvm_error (get_type_name(),$sformatf("Size of MISO data in Master and Slave is not equal"));
   end

  foreach(slave_tx_h.master_in_slave_out[i]) begin
      if(slave_tx_h.master_in_slave_out[i] != master_tx_h.master_in_slave_out[i]) begin
        `uvm_error("ERROR_SC_MISO_DATA_MISMATCH", 
                  $sformatf("Slave MISO[%0d] = 'h%0x and Master MISO[%0d] = 'h%0x", 
                            i, slave_tx_h.master_in_slave_out[i],
                            i, master_tx_h.master_in_slave_out[i]) );
        byte_data_cmp_failed_miso_count++;
      end
      else begin
        `uvm_info("SB_MISO_DATA_MATCH", 
                  $sformatf("Slave MISO[%0d] = 'h%0x and Master MISO[%0d] = 'h%0x", 
                            i, slave_tx_h.master_in_slave_out[i],
                            i, master_tx_h.master_in_slave_out[i]), UVM_HIGH);
        byte_data_cmp_verified_miso_count++;
      end
    end

// Done this part in report phase
// MSHA:   // TODO(mshariff): After comparisions, keep a track of the sno of comparisions done
  end

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  // TODO(mshariff): Banner as discussed
  // `uvm_info (get_type_name(),$sformatf(" Scoreboard Check Phase is starting"),UVM_HIGH); 
  $display(" ");
  $display("-------------------------------------------- ");
  $display("SCOREBOARD CHECK PHASE");
  $display("-------------------------------------------- ");
  $display(" ");
// TODO(mshariff): Check the following:

// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error
  
  if ((byte_data_cmp_verified_mosi_count != 0)&&(byte_data_cmp_failed_mosi_count == 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all mosi comparisions are succesful"),UVM_NONE);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_mosi_count :%0d",
                                            byte_data_cmp_verified_mosi_count),UVM_NONE);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_mosi_count : %0d", 
                                            byte_data_cmp_failed_mosi_count),UVM_NONE);
    `uvm_error (get_type_name(), $sformatf ("comparisions of mosi not happened"));
  end

  if ((byte_data_cmp_verified_miso_count != 0)&&(byte_data_cmp_failed_miso_count == 0) ) begin
	  `uvm_info (get_type_name(), $sformatf ("all miso comparisions are succesful"),UVM_NONE);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_verified_miso_count :%0d",
                                            byte_data_cmp_verified_miso_count),UVM_NONE);
	  `uvm_info (get_type_name(), $sformatf ("byte_data_cmp_failed_miso_count : %0d", 
                                            byte_data_cmp_failed_miso_count),UVM_NONE);
  end

// 2. Check if master packets received are same as slave packets received
//    To Make sure that we have equal number of master and slave packets
  
 if (master_tx_count == slave_tx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("master and slave have equal no. of transactions"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("master_tx_count : %0d",master_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("slave_tx_count : %0d",slave_tx_count ),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("master and slave doesnot have same no. of transactions"));
  end 


// 3. Analyis fifos must be zero - This will indicate that all the packets have been compared
//    This is to make sure that we have taken all packets from both FIFOs and made the
//    comparisions
   
  if (master_analysis_fifo.size() == 0)begin
    // TODO(mshariff): Chnage the info's to errors
     `uvm_info (get_type_name(), $sformatf ("Master analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("master_analysis_fifo:%0d",master_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("Master analysis FIFO is not empty"));
  end
  if (slave_analysis_fifo.size()== 0)begin
    // TODO(mshariff): Chnage the info's to errors
     `uvm_info (get_type_name(), $sformatf ("Slave analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("slave_analysis_fifo:%0d",slave_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("Slave analysis FIFO is not empty"));
  end

endfunction : check_phase

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  //`uvm_info("scoreboard",$sformatf("Scoreboard Report"),UVM_HIGH);
  
  // TODO(mshariff): Print the below items:
  // TODO(mshariff): Banner as discussed
  $display(" ");
  $display("-------------------------------------------- ");
  $display("SCOREBOARD REPORT PHASE");
  $display("-------------------------------------------- ");
  $display(" ");
  // Total number of packets received from the Master
  `uvm_info (get_type_name(),$sformatf("No. of transactions from master:%0d",
                             master_tx_count),UVM_NONE);

  //Total number of packets received from the Slave (with their ID)
  `uvm_info (get_type_name(),$sformatf("No. of transactions from slave:%0d", 
                             slave_tx_count),UVM_NONE);
  
//  //Number of mosi comparisions done
//  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise mosi comparisions:%0d",
//                 byte_data_cmp_verified_mosi_count+byte_data_cmp_failed_mosi_count),UVM_HIGH);
//  //Number of miso comparisions done
//  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise miso comparisions:%0d",
//                 byte_data_cmp_verified_miso_count+byte_data_cmp_failed_miso_count),UVM_HIGH);
  
  //Number of mosi comparisios passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise mosi comparisions passed:%0d",
                byte_data_cmp_verified_mosi_count),UVM_NONE);

  //Number of miso comparisios passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte wise miso comparisions passed:%0d",
                byte_data_cmp_verified_miso_count),UVM_NONE);
  
  //Number of mosi compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise mosi comparision failed:%0d",
                byte_data_cmp_failed_mosi_count),UVM_NONE);

  //Number of miso compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of byte wise miso comparision failed:%0d",
                byte_data_cmp_failed_miso_count),UVM_NONE);

endfunction : report_phase

`endif
