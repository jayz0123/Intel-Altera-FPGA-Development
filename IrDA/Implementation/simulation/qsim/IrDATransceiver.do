onerror {quit -f}
vlib work
vlog -work work IrDATransceiver.vo
vlog -work work IrDATransceiver.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ReceiverController_vlg_vec_tst
vcd file -direction IrDATransceiver.msim.vcd
vcd add -internal ReceiverController_vlg_vec_tst/*
vcd add -internal ReceiverController_vlg_vec_tst/i1/*
add wave /*
run -all
