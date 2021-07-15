# loads first operand 
lui $s0, 0x0000
addiu $s0, $s0, 0x0f0f
# loads second operand
lui $s1, 0x0000
addiu $s1, $s1, 0x00ff
# the address of LED_R
lui $t0, 0x0000
addiu $t0, $t0, 0x2008
# 0x0F0F nor 0x00FF
nor $s2, $s0, $s1
# LED_R to display the result
sw $s2, 0x0000($t0)
