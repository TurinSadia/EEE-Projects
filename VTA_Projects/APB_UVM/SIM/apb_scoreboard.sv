class apb_scb extends uvm_scoreboard;
  `uvm_component_utils(apb_scb)
  apb_mntr mntr;
  apb_seq_item item;
  uvm_analysis_imp #(apb_seq_item, apb_scb) scb_imp;
  bit [dataWidth - 1:0] apb[bit[addrWidth-1:0]];

  
  int passed=0;
  int failed=0;
  


  function new(string name = "apb_scb", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //item = apb_seq_item::type_id::create("item");
    scb_imp = new("scb_imp", this);
    $display($time, "ns || [SCOREBOARD] SCOREBOARD GOT VALUES FROM MONITOR");
  endfunction


  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  //run phase


  virtual function void write(apb_seq_item item);
    if (!item.rst_n) begin
      // Handle reset condition if needed
      item.opp = RESET;
      apb.delete();
    end
    else if (item.rst_n  && item.penable && item.pwrite) begin
      // Write operation
      apb[item.paddr] = item.pwdata;
    end
    else if (item.rst_n && item.penable && !item.pwrite) begin
      // Read operation, call compare
      compare(item);
    end
    else begin
      item.opp = IDLE;
    end

    $display($time, "ns || [SCOREBOARD] SCOREBOARD GOT ", item.opp.name());
  endfunction

  function void compare(apb_seq_item item);

    if(!apb.exists(item.paddr))begin
      apb[item.paddr] = 10;
    end

    if(item.prdata === apb[item.paddr])  begin
      $display($time, "ns || [SCOREBOARD] | Passed | [Address : %0d] ,[apb[item.paddr] : %0d] , [Expected Data : %0d] ,[Actual Data : %0d]",item.paddr,apb[item.paddr],item.pwdata,item.prdata);
      passed++;
      $display($time, "ns | Passed Count",passed);
    end 

    else begin
      $display($time, "ns || [SCOREBOARD] | Failed |[Address : %0d] ,[apb[item.paddr] : %0d] , [Expected Data : %0d] ,[Actual Data : %0d]",item.paddr,apb[item.paddr],item.pwdata,item.prdata);
      failed++;
      $display($time, "ns | Failed Count ",failed);
    end
  endfunction 

  task scb_report();
    $display($time, "ns |[SCOREBOARD] Report: Passed = %0d, Failed = %0d", passed, failed);
  endtask: scb_report


endclass : apb_scb
