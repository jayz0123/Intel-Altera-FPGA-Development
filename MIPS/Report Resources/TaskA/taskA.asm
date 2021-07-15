# number 0
lui $s0, 0x0000
addiu $s0, $s0, 0x0040
# number 1
lui $s1, 0x0000
addiu $s1, $s1, 0x0079
# number 3
lui $s2, 0x0000
addiu $s2, $s2, 0x0030
# number 7
lui $s3, 0x0000
addiu $s3, $s3, 0x0078
# number 7
lui $s4, 0x0000
addiu $s4, $s4, 0x0078
# number 2
lui $s5, 0x0000
addiu $s5, $s5, 0x0024
# number 4
lui $s6, 0x0000
addiu $s6, $s6, 0x0019
# number 4
lui $s7, 0x0000
addiu $s7, $s7, 0x0019

# 7-segment HEX7
lui $t0, 0xffff
addiu $t0, $t0, 0x202C
# 7-segment HEX6
lui $t1, 0xffff
addiu $t1, $t1, 0x2028
# 7-segment HEX5
lui $t2, 0xffff
addiu $t2, $t2, 0x2024
# 7-segment HEX4
lui $t3, 0xffff
addiu $t3, $t3, 0x2020
# 7-segment HEX3
lui $t4, 0xffff
addiu $t4, $t4, 0x201C
# 7-segment HEX2
lui $t5, 0xffff
addiu $t5, $t5, 0x2018
# 7-segment HEX1
lui $t6, 0xffff
addiu $t6, $t6, 0x2014
# 7-segment HEX0
lui $t7, 0xffff
addiu $t7, $t7, 0x2010

# stores the values into the 7-segment registers
sw $s0, 0x0000($t0)
sw $s1, 0x0000($t1)
sw $s2, 0x0000($t2)
sw $s3, 0x0000($t3)
sw $s4, 0x0000($t4)
sw $s5, 0x0000($t5)
sw $s6, 0x0000($t6)
sw $s7, 0x0000($t7)

while: j while