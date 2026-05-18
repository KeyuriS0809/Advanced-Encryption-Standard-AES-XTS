class driver;
  transaction trans = new();

  mailbox #(transaction) gen2drv;
  virtual intf vif;

  function new(mailbox #(transaction) gen2drv, virtual intf vif);
    this.vif      = vif;
    this.gen2drv  = gen2drv;
  endfunction

  task main;
    forever begin

      @(negedge vif.i_clk);

      if (vif.i_reset) begin
        vif.i_XTS_START     <= 0;
        vif.i_J             <= 0;
        vif.i_SECTOR        <= 0;
        vif.i_XTS_PLAINTEXT <= 0;
        vif.i_KEY_1         <= 0;
        vif.i_KEY_2         <= 0;
      end
      else  begin
        gen2drv.get(trans);
        vif.i_XTS_START     <= trans.i_XTS_START;
        vif.i_J             <= trans.i_J;
        vif.i_SECTOR        <= trans.i_SECTOR;
        vif.i_XTS_PLAINTEXT <= trans.i_XTS_PLAINTEXT;
        vif.i_KEY_1         <= trans.i_KEY_1;
        vif.i_KEY_2         <= trans.i_KEY_2;
      end

      trans.display("DRIVER");

      @(negedge vif.i_clk);
      vif.i_XTS_START  <= 0;
    end
  endtask
endclass
