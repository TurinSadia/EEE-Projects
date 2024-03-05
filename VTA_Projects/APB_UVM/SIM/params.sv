parameter addrWidth = 32;
parameter dataWidth = 32;
typedef enum{RESET,WRITE,READ,IDLE} OPERATION;
typedef bit [addrWidth-1:0] ADDR_VAL;
typedef bit [dataWidth-1:0] DATA_VAL;
typedef enum {NA, FAILED, PASSED} VALIDITY;