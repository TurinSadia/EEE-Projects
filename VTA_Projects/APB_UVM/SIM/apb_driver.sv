class apb_drvr extends uvm_driver #(apb_seq_item);
  `uvm_component_utils(apb_drvr)
  virtual apb_interface INTF;
  apb_seq_item item;

  function new(string name="apb_drvr", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);


    if(!uvm_config_db #(virtual apb_interface)::get(null,"*","apb_interface",INTF))begin
      `uvm_fatal(get_full_name(),"SIMULATION STOPPED ||[DRIVER] DRIVER COULDN'T GET INTERFACE")
    end
    else
      $display($time,"ns ||[DRIVER]  DRIVER GOT INTERFACE");
    item= apb_seq_item::type_id::create("item");
  endfunction


  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      seq_item_port.get_next_item(item);
      drive(item);
      seq_item_port.item_done();
    end
  endtask

  // ---------------Call DRIVE Task----------------------------------------------

  task drive(apb_seq_item item);

    INTF.pwdata<= item.pwdata;
    INTF.pwrite<= item.pwrite;
    INTF.psel<= item.psel;
    INTF.rst_n<= 1;
    INTF.paddr<= item.paddr;
    INTF.penable<= item.penable;

    if(item.opp == RESET) begin
      INTF.rst_n <= 0;
      INTF.penable<=0;
      INTF.psel<=0;
      INTF.pwrite <= 0;
      INTF.pwdata<=0;
      INTF.paddr<=0;
      @(negedge INTF.clk);
    end



    if(item.opp == IDLE) begin
      INTF.rst_n <= 1;
      INTF.penable<=0;
      INTF.psel<=0;
      INTF.pwrite <= 0;
      INTF.pwdata<=0;
      INTF.paddr<=0;
      @(negedge INTF.clk);
    end

    if(item.opp==WRITE) begin
      INTF.pwrite<=1;
      INTF.psel<=1;
      INTF.penable<=0;
      INTF.paddr<=item.paddr;
      INTF.pwdata<=item.pwdata;
      @(negedge INTF.clk);
      INTF.penable<=1;
      @(negedge INTF.pready);
      @(negedge INTF.clk);

    end


    if(item.opp==READ) begin
      INTF.pwrite<=0;
      INTF.psel<=1;
      INTF.penable<=0;
      INTF.paddr<=item.paddr;
      @(negedge INTF.clk);
      INTF.penable<=1;
      @(negedge INTF.pready);
      @(negedge INTF.clk);


    end

    //     $display($time, "ns ||[DRVR] [Line: 95][ [OPERATION = %s], [paddr = %0d], [pwdata = %0d] , [prdata = %0d]", item.opp.name(), INTF.paddr, INTF.pwdata, INTF.prdata);

  endtask


endclass:apb_drvr