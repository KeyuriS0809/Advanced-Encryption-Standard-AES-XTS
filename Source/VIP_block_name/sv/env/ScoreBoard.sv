class scoreboard;

  transaction trans;
  mailbox #(transaction) mon2score;

  function new (mailbox #(transaction) mon2score);
    this.mon2score = mon2score;
  endfunction

  task main;
    trans = new();

    forever begin 
      mon2score.get(trans);
      trans.display("SCORE BOARD");
      files_pkg :: Count();

      reference();
      files_pkg :: drop();
      $display("--------------------------------------------------------------------------------------------------");
      $display("====================================== TRANSACTION COMPLETE ======================================");
      $display("--------------------------------------------------------------------------------------------------");
    end
  endtask

  extern task reference();
    extern task Expected(input [`PLAINTEXT_WIDTH-1:0] Ex_Cipher);  
endclass

task scoreboard::reference();
  begin
    $display("--------------------------- REFERENCE --------------------------------------");
    
    // ------------- For All Zero Test ----------
    if (trans.i_XTS_PLAINTEXT == 256'h00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000) begin
      if (trans.i_KEY_1 == 128'h00000000_00000000_00000000_00000000)
        Expected(256'h917cf69e_bd68b2ec_9b9fe9a3_eadda692_cd43d2f5_9598ed85_8c02c265_2fbf922e);
    end
    
    // ------------- For TEST - 2 ----------
    if (trans.i_XTS_PLAINTEXT == 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444) begin
      if (trans.i_KEY_1 == 128'h11111111_11111111_11111111_11111111)
        Expected(256'hc454185e_6a16936e_39334038_acef838b_fb186fff_7480adc4_289382ec_d6d394f0);
      else 
        // ------------- For TEST - 3 ----------
        if (trans.i_KEY_1 == 128'hfffefdfc_fbfaf9f8_f7f6f5f4_f3f2f1f0)
          Expected(256'haf85336b_597afc1a_900b2eb2_1ec949d2_92df4c04_7e0b2153_2186a597_1a227a89);
    end
    
      $display("--------------------------------------------------------------------------");
  end
endtask
    
      task scoreboard::Expected(input [`PLAINTEXT_WIDTH-1:0] Ex_Cipher);
  begin
    if (files_pkg :: COUNT == 1) begin
      if (trans.o_XTS_CIPHERTEXT == Ex_Cipher) begin
        $display("***************************************  BLOCK PASSS ***************************************");
        $display("Expected Cipher text = %h",Ex_Cipher);
      end
      else begin
        $display("***************************************  BLOCK FAILL ***************************************");
        $display("Expected Cipher text = %h",Ex_Cipher);
      end
    end
    else if (files_pkg :: COUNT == 2) begin
      if (trans.o_XTS_CIPHERTEXT == Ex_Cipher)begin
        $display("***************************************  BLOCK PASSS ***************************************");
        $display("Expected Cipher text = %h",Ex_Cipher);
      end
      else begin
        $display("***************************************  BLOCK FAILL ***************************************");
        $display("Expected Cipher text = %h",Ex_Cipher);
      end
    end
  end
endtask    
