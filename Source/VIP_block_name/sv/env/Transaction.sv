class transaction;
  bit                         i_clk;
  bit                         i_reset;
  bit                         i_XTS_START;
  bit [`BLOCK_NUMBER-1:0]     i_J;
  bit [`CIPHERTEXT_WIDTH-1:0] i_SECTOR;
  bit [`PLAINTEXT_WIDTH-1:0]  i_XTS_PLAINTEXT;
  bit [`KEY_WIDTH-1:0]        i_KEY_1;
  bit [`KEY_WIDTH-1:0]        i_KEY_2;

  bit [`PLAINTEXT_WIDTH-1:0] o_XTS_CIPHERTEXT;
  bit                       o_XTS_DONE;
  
  function void display(string name);
    $display("\n----------------------------------[ %s ]--------------------------------------",name);
    $display("TIME = %0t        Total Block  = %d",$time,i_J);
    $display("TIME = %0t            i_SECTOR = %h",$time,i_SECTOR);
    $display("TIME = %0t            KEY - 1  = %h",$time,i_KEY_1);
    $display("TIME = %0t            KEY - 2  = %h",$time,i_KEY_2);
    $display("TIME = %0t    i_XTS_PLAINTEXT  = %h",$time,i_XTS_PLAINTEXT);
    $display("TIME = %0t    o_XTS_CIPHERTEXT = %h",$time,o_XTS_CIPHERTEXT);
  endfunction
endclass
