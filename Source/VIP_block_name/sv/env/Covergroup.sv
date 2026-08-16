covergroup aes_xts_cg with function sample(my_item m_trans);

//   option.per_instance = 1;
  
  block_j_cp : coverpoint m_trans.i_J {
    bins max_block = {2};
  }
  
  sector_i_cp : coverpoint m_trans.i_SECTOR {
    bins all_zeros = {128'h00000000_00000000_00000000_00000000};
    bins test_2_3    = {128'h33333333_33000000_00000000_00000000};
  }
  
  Key1_cp : coverpoint m_trans.i_KEY_1 {
    bins all_zeros = {128'h0};
    bins test_2 = {128'h11111111_11111111_11111111_11111111};
    bins test_3 = {128'hfffefdfc_fbfaf9f8_f7f6f5f4_f3f2f1f0};
  }
  
  Key2_cp : coverpoint m_trans.i_KEY_2 {
    bins all_zeros = {128'h0};
    bins test_2_3 = {128'h22222222_22222222_22222222_22222222};
  }
  
  plaintext_cp : coverpoint m_trans.i_XTS_PLAINTEXT {
    bins all_zeros = {256'h0};
    bins test_2_3 = {256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444};
  }
  
  ciphertext_cp : coverpoint m_trans.o_XTS_CIPHERTEXT {
    bins all_zeros = {256'h917cf69e_bd68b2ec_9b9fe9a3_eadda692_cd43d2f5_9598ed85_8c02c265_2fbf922e};
    bins test_2 = {256'hc454185e_6a16936e_39334038_acef838b_fb186fff_7480adc4_289382ec_d6d394f0};
    bins test_3 = {256'haf85336b_597afc1a_900b2eb2_1ec949d2_92df4c04_7e0b2153_2186a597_1a227a89};
  }
endgroup
