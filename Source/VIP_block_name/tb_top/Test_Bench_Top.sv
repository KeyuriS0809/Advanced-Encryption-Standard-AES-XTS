`include "Package.sv"
import files_pkg :: *; 
`include "Interface.sv"

module Test_Bench_Top;

  logic clock;

  intf intff(clock);
  TEST tst;

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
    $dumpfile("dump.vcd"); $dumpvars;
  end

  initial begin

    clock = 1;  

    tst = new(intff);

    if($test$plusargs("All_zero"))
      tst = All_zero::new(intff);

    else if($test$plusargs("Test_2"))
      tst = Test_2::new(intff);

    else if($test$plusargs("Test_3"))
      tst = Test_3::new(intff);

    else
      $error("TEST NOT FOUND ENTER VALID TEST NAME");

//     tst.reset();
    tst.run();

    wait(files_pkg::raise_cnt == 0);
    $display($time,, "reset is called from test");
    $finish;
  end

endmodule
