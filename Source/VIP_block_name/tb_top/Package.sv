package files_pkg;
  
  `define BLOCK_NUMBER  2
  `define PLAINTEXT_WIDTH  (128 * `BLOCK_NUMBER)
  `define KEY_WIDTH   128
  `define CIPHERTEXT_WIDTH  128

  int raise_cnt = 0;
  int COUNT = 0;

  function void raise();
    raise_cnt++;
    $display("RAISE COUNT INC = %0d", raise_cnt);
  endfunction

  function void drop();
    raise_cnt--;
    $display("RAISE COUNT DEC = %0d", raise_cnt);
  endfunction 

function void Count();
    COUNT++;
  $display("BLOCK NUMBER = %0d", raise_cnt);
  endfunction 

  `include "Transaction.sv"
  `include "Generator.sv"
  `include "Driver.sv"
  `include "Monitor.sv"
  `include "ScoreBoard.sv"
  `include "ENV.sv"
  `include "Test.sv"

  // -------- TEST FILES ---------
  `include "All_zero.sv"
  `include "Test_2.sv"
  `include "Test_3.sv"

endpackage
