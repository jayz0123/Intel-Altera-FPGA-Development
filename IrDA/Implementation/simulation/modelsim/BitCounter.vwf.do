vlog -work work D:/Assignment_2/simulation/modelsim/BitCounter.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.BitCounter_vlg_vec_tst
onerror {resume}
add wave {BitCounter_vlg_vec_tst/i1/bit_done}
add wave {BitCounter_vlg_vec_tst/i1/clk}
add wave {BitCounter_vlg_vec_tst/i1/ena}
add wave {BitCounter_vlg_vec_tst/i1/inc}
add wave {BitCounter_vlg_vec_tst/i1/rst}
run -all
