`include "Package.sv"
import uvm_pkg::*;
import files_pkg :: *; 
`include "Interface.sv"

module Test_Bench_Top;

  logic clock;

  my_intf intff(clock);      // Inerface Instace       

  XTS_TOP XTS_DUT (.i_clk(intff.i_clk), 
                   .i_reset(intff.i_reset),
                   .i_KEY_1(intff.i_KEY_1),
                   .i_KEY_2(intff.i_KEY_2), 
                   .i_XTS_PLAINTEXT(intff.i_XTS_PLAINTEXT), 
                   .i_XTS_START(intff.i_XTS_START),
                   .i_SECTOR(intff.i_SECTOR),
                   .i_J( intff.i_J),
                   .o_XTS_CIPHERTEXT(intff.o_XTS_CIPHERTEXT), 
                   .o_XTS_DONE(intff.o_XTS_DONE));


  always #5 clock = ~clock;

  initial begin 
    clock = 0;
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin
    uvm_config_db #(virtual my_intf)::set(null, "*", "vif", intff);
    run_test("Random_Test");
  end
endmodule
