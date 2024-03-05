module apb_top;

  //Clk Generator
  bit clk;
  always #5 clk = ~clk;

  //INTF
  apb_interface INTF(clk);




  //DUT

  apb_rtl DUT(
    .pclk(INTF.clk),
    .rst_n(INTF.rst_n),
    .paddr(INTF.paddr),
    .pwrite(INTF.pwrite),
    .psel(INTF.psel),
    .penable(INTF.penable),
    .pwdata(INTF.pwdata),

    //output pins
    .pready(INTF.pready),
    .prdata(INTF.prdata),
    .pslverr(INTF.pslverr)
  );

  initial begin
    uvm_config_db #(virtual apb_interface)::set(null,"*","apb_interface",INTF);
    run_test("apb_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,apb_top);
  end

endmodule