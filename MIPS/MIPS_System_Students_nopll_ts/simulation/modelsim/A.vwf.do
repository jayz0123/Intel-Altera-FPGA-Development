vlog -work work D:/MIPS_System_Students_nopll_ts/simulation/modelsim/A.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.MIPS_System_vlg_vec_tst
onerror {resume}
add wave {MIPS_System_vlg_vec_tst/i1/CLOCK_50}
add wave {MIPS_System_vlg_vec_tst/i1/KEY[0]}
run -all
