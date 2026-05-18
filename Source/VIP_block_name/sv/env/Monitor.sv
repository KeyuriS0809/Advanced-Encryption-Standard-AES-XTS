class monitor;

  transaction trans;
  mailbox #(transaction) mon2score;
  virtual intf vif;

  function new (mailbox #(transaction) mon2score, virtual intf vif);
    this.mon2score = mon2score;
    this.vif = vif;
  endfunction

  task main;
    trans = new();

    forever begin
      
      @(vif.o_XTS_DONE);
//       @(posedge vif.i_clk);
      @(negedge vif.i_clk);

      trans.i_XTS_START      =  vif.i_XTS_START;
      trans.i_J              =  vif.i_J;
      trans.i_SECTOR         =  vif.i_SECTOR;
      trans.i_XTS_PLAINTEXT  =  vif.i_XTS_PLAINTEXT;
      trans.i_KEY_1          =  vif.i_KEY_1;
      trans.i_KEY_2          =  vif.i_KEY_2;
      trans.o_XTS_DONE       =  vif.o_XTS_DONE;
      trans.o_XTS_CIPHERTEXT =  vif.o_XTS_CIPHERTEXT;

      mon2score.put(trans);      
      trans.display("MONITOR");
    end
  endtask
endclass
