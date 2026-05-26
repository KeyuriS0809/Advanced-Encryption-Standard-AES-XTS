class Test_2 extends TEST;

  transaction trans;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  task run();

    env.test_run();
    trans = new();
    files_pkg :: raise();

    trans.i_J = 4'd2;
    trans.i_XTS_START = 1;
    trans.i_SECTOR = 128'h33333333_33000000_00000000_00000000;
    trans.i_XTS_PLAINTEXT = 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444;
    trans.i_KEY_1 = 128'h11111111_11111111_11111111_11111111;
    trans.i_KEY_2 = 128'h22222222_22222222_22222222_22222222;

    env.gen.send(trans);
  endtask
endclass
