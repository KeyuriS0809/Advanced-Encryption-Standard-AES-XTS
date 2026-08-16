class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
  
  my_item m_trans;
  uvm_analysis_imp #(my_item, my_scoreboard) m_actual_export;
  
  function new(string name = "my_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_actual_export = new("m_actual_export", this);
  endfunction

  virtual function void write(my_item txn);
    m_trans = txn;
    // ------------- For All Zero Test ----------
    if (m_trans.i_XTS_PLAINTEXT == 256'h00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000) begin
      if (m_trans.i_KEY_1 == 128'h00000000_00000000_00000000_00000000)
        Expected(256'h917cf69e_bd68b2ec_9b9fe9a3_eadda692_cd43d2f5_9598ed85_8c02c265_2fbf922e);
    end

    // ------------- For TEST - 2 ----------
    if (m_trans.i_XTS_PLAINTEXT == 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444) begin
      if (m_trans.i_KEY_1 == 128'h11111111_11111111_11111111_11111111)
        Expected(256'hc454185e_6a16936e_39334038_acef838b_fb186fff_7480adc4_289382ec_d6d394f0);
      else 
        // ------------- For TEST - 3 ----------
        if (m_trans.i_KEY_1 == 128'hfffefdfc_fbfaf9f8_f7f6f5f4_f3f2f1f0)
          Expected(256'haf85336b_597afc1a_900b2eb2_1ec949d2_92df4c04_7e0b2153_2186a597_1a227a89);
    end

    m_trans.print();
    `uvm_info(get_type_name(),"============================= TRANSACTION COMPLETE ===============================", UVM_LOW)
    `uvm_info(get_type_name(),"----------------------------------------------------------------------------------", UVM_LOW)
  endfunction

  extern function void Expected(input [`PLAINTEXT_WIDTH-1:0] Ex_Cipher);

endclass

function void my_scoreboard::Expected(input [`PLAINTEXT_WIDTH-1:0] Ex_Cipher);
  begin
    if (m_trans.o_XTS_CIPHERTEXT == Ex_Cipher) begin
      `uvm_info(get_type_name(),"***************************************  BLOCK PASSS ***************************************", UVM_LOW);
      `uvm_info(get_type_name(),$sformatf("Expected Cipher text = %h",Ex_Cipher), UVM_LOW);
    end
    else begin
      `uvm_error(get_type_name(),"***************************************  BLOCK FAILL ***************************************");
      `uvm_info(get_type_name(),$sformatf("Expected Cipher text = %h",Ex_Cipher), UVM_LOW);
    end
  end
endfunction
