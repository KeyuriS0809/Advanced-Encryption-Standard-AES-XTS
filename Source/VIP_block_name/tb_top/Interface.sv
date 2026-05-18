interface intf(input logic i_clk);
  
  logic                        i_reset;
  logic                        i_XTS_START;
  
  logic [`BLOCK_NUMBER-1:0]     i_J;             // Block Number
  logic [`CIPHERTEXT_WIDTH-1:0] i_SECTOR;        // Sector Number - i
  logic [`PLAINTEXT_WIDTH-1:0]  i_XTS_PLAINTEXT; // Plaintext 
  logic [`KEY_WIDTH-1:0]        i_KEY_1;         // Key for 2nd Encryption
  logic [`KEY_WIDTH-1:0]        i_KEY_2;         // Key for Tweak Generation 

  logic [`PLAINTEXT_WIDTH-1:0] o_XTS_CIPHERTEXT; // Ciphertext
  logic                        o_XTS_DONE;         
  
endinterface 
