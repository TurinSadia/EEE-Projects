class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  apb_env env;

  // Class declared in apb_sequence.sv
  reset_seq rst_seq;
  idle_seq idl_seq;
  write_seq wr_seq;
  read_seq rd_seq;

  function new(string name="apb_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // uvm_config_db #(apb_env)::set(this, "*", "env", env);
    env=apb_env::type_id::create("env",this);

    // Build Handle of the Sequences
    rst_seq = reset_seq::type_id::create("rst_seq",this);
    wr_seq = write_seq::type_id::create("wr_seq",this);
    rd_seq = read_seq::type_id::create("rd_seq",this);
    idl_seq = idle_seq::type_id::create("idl_seq",this);
  endfunction


  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    //super.run_phase(phase);

    phase.raise_objection(this);

    //--------------------- FOR RESET-----------------------------
    rst_seq.start(env.agnt.sqncr);

    //--------------------- FOR READ-----------------------------
    //rd_seq.paddr = wr_seq.paddr;
//     rd_seq.paddr = 5;
//     rd_seq.start(env.agnt.sqncr);

    //--------------------- FOR IDLE-----------------------------
   // idl_seq.start(env.agnt.sqncr);
    
        //--------------------- FOR READ-----------------------------
    //rd_seq.paddr = wr_seq.paddr;
    rd_seq.paddr = 13;
    rd_seq.start(env.agnt.sqncr);
    

    //--------------------- FOR WRITE-----------------------------
    wr_seq.randomize() with {
      wr_seq.paddr inside {[0:255]};
      wr_seq.pwdata inside {[0:255]};

    };
    //     wr_seq.pwdata =5;
    //     wr_seq.paddr =10;

    //     wr_seq.pwdata =15;
    //     wr_seq.paddr =13;
    wr_seq.start(env.agnt.sqncr);

//     //--------------------- FOR READ-----------------------------

    rd_seq.paddr = wr_seq.paddr;
    //rd_seq.paddr = 15;
    rd_seq.start(env.agnt.sqncr);

    phase.drop_objection(this);
  endtask


endclass:apb_test