class Test_3 extends TEST;

  transaction trans;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  task run();
    reset();
    env.test_run();
    trans = new();
    files_pkg :: raise();

    trans.i_J = 4'd2;
      trans.i_XTS_START = 1;
      trans.i_SECTOR = 128'h33333333_33000000_00000000_00000000;
      trans.i_XTS_PLAINTEXT = 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444;
      trans.i_KEY_1 = 128'hfffefdfc_fbfaf9f8_f7f6f5f4_f3f2f1f0;
      trans.i_KEY_2 = 128'h22222222_22222222_22222222_22222222;

//       @(negedge i_clk);
//       i_XTS_START =  0;

      env.gen.send(trans);
  endtask
endclass
