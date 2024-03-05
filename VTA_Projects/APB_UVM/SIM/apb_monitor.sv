class apb_mntr extends uvm_monitor;
  `uvm_component_utils(apb_mntr)
  apb_seq_item item;
  virtual apb_interface INTF;
  uvm_analysis_port #(apb_seq_item) mntr_port;

  function new(string name="apb_mntr", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mntr_port=new("mntr_port",this);

    if(!uvm_config_db #(virtual apb_interface)::get(null,"*","apb_interface",INTF)) begin
      `uvm_fatal(get_full_name(),"SIMULATION STOPPED || MONITOR COULDN'T GET INTERFACE")
    end
    else 
      $display($time,"ns ||[MONITOR] MONITOR GOT INTERFACE");
    item=apb_seq_item::type_id::create("item");

  endfunction


  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge INTF.clk);
      item.paddr=INTF.paddr;
      item.pwrite=INTF.pwrite;
      item.rst_n=INTF.rst_n;
      item.psel=INTF.psel;

      if(!INTF.rst_n) item.opp=RESET;
      
      else if(INTF.rst_n  && INTF.psel) begin
        @(posedge INTF.penable);
        item.penable=INTF.penable;

        if(INTF.penable && INTF.pwrite)
          begin
            item.opp=WRITE;
            @(posedge INTF.pready);
            item.pwdata=INTF.pwdata;
            item.pslverr=INTF.pslverr;
            item.pready=INTF.pready;
            @(posedge INTF.clk);
            
          end
        else
          begin
            item.opp=READ;
            @(posedge INTF.pready);
            item.prdata=INTF.prdata;
            item.pslverr=INTF.pslverr;
            item.pready=INTF.pready;
            @(posedge INTF.clk);
            
          end


      end
      else item.opp=IDLE;

      $display($time, "ns ||[MONITOR] MONITOR GOT ITEM ||[OPERATION = %s], [paddr = %0d], [pwdata = %0d] , [prdata = %0d]", item.opp.name(), INTF.paddr, INTF.pwdata, INTF.prdata);

      mntr_port.write(item);
      //$display($time,"ns ||[MONITOR] MONITOR SENT VALUES TO SCOREBOARD ");

    end

  endtask


endclass:apb_mntr