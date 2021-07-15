onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_System_vlg_vec_tst/i1/CLOCK_50
add wave -noupdate {/MIPS_System_vlg_vec_tst/i1/KEY[0]}
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/mips_cpu/pc
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/mips_cpu/instr
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX7
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX6
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX5
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX4
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX3
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX2
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX1
add wave -noupdate -radix hexadecimal /MIPS_System_vlg_vec_tst/i1/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3453076 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3453076 ps}
