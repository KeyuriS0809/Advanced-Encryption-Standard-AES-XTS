package files_pkg;
  
  `include "uvm_macros.svh"
   import uvm_pkg::*;

  `define BLOCK_NUMBER  2
  `define PLAINTEXT_WIDTH  (128 * `BLOCK_NUMBER)
  `define KEY_WIDTH   128
  `define CIPHERTEXT_WIDTH  128

  `include "seq_item.sv"

  // ----- Coverage files -------
  `include "Covergroups.sv"
  `include "Coverage.sv"
  `include "rand_covergroup.sv"
  `include "rand_coverage.sv"

  `include "sequence.sv"
  `include "sequencer.sv"
  `include "Driver.sv"
  `include "Monitor.sv"
  `include "ScoreBoard.sv"
  `include "agent.sv"
  `include "ENV.sv"
  `include "Base_test.sv"

  // -------- TEST FILES ---------
  `include "All_zero.sv"
  `include "Test_2.sv"
  `include "Test_3.sv"
  `include "Multi_Test.sv"
  `include "random_test.sv"

endpackage
