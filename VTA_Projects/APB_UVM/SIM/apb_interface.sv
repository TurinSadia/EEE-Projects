interface apb_interface #(addrWidth = 32, dataWidth = 32) (input bit clk);
  
  bit rst_n;
  
//For Input pins
  logic psel,pwrite,penable;
  logic [addrWidth-1:0] paddr;
  logic [dataWidth-1:0] pwdata;
  
//For Output pins 
  logic pready,pslverr;
  logic [dataWidth-1:0] prdata;
  
endinterface:apb_interface