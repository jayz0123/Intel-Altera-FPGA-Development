transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/ClockBlk {D:/MIPS_System_Students_nopll_ts/ClockBlk/ClockBlk.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts {D:/MIPS_System_Students_nopll_ts/MIPS_System.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/MIPS_CPU {D:/MIPS_System_Students_nopll_ts/MIPS_CPU/mips.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/MIPS_CPU {D:/MIPS_System_Students_nopll_ts/MIPS_CPU/mipsparts.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/Alera_Mem_Dual_Port {D:/MIPS_System_Students_nopll_ts/Alera_Mem_Dual_Port/ram2port_inst_data.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/Decoder {D:/MIPS_System_Students_nopll_ts/Decoder/Addr_Decoder.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/GPIO {D:/MIPS_System_Students_nopll_ts/GPIO/GPIO.v}
vlog -vlog01compat -work work +incdir+D:/MIPS_System_Students_nopll_ts/Timer {D:/MIPS_System_Students_nopll_ts/Timer/TimerCounter.v}

