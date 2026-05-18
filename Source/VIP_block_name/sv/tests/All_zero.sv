class All_zero extends TEST;

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
      trans.i_SECTOR = 128'h00000000_00000000_00000000_00000000;
      trans.i_XTS_PLAINTEXT = 256'h00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
      trans.i_KEY_1 = 128'h00000000_00000000_00000000_00000000;
      trans.i_KEY_2 = 128'h00000000_00000000_00000000_00000000;
    env.gen.send(trans);
    
//     trans = new();
//     @(negedge vif.i_clk);
//     trans.i_XTS_START = 0;
//     env.gen.send(trans);

  endtask
endclass
