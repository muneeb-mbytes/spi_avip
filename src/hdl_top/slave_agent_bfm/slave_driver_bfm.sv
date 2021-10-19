//--------------------------------------------------------------------------------------------
// Module       : Slave Driver BFM
// Description  : Connects the slave driver bfm with the driver proxy
//--------------------------------------------------------------------------------------------
interface slave_driver_bfm(spi_if intf);

  slave_driver_proxy sd_proxy_h;

  initial begin
    $display("Slave Driver BFM");
  end

  function void set_mode(bit mode_in);
    mode <= mode_in;
  endfunction

  task read(bit cpol, cphase, output bit [7:0] data);
    @(posedge intf.sclk);
    intf.cpol <= cpol;
    intf.cphase <= cphase;
  endtask

  task write(bit cpol, cphase, bit [7:0] data);
 //   @(posedge intf.sclk);
 //   intf.cpol <= cpol;
 //   intf.cphase <= cphase;
  endtask

endinterface : slave_driver_bfm
