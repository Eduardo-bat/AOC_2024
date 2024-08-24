j main

factorial:
lw $t0, 0($sp)
addi $sp, $sp, 4
bne $t0, $0, greater_than_one
addi $t1, $0, 1
addi $sp, $sp, -4
sw $t1, 0($sp)
jr $ra
greater_than_one:
addi $t1, $t0, -1
addi $sp, $sp,  -12
sw $ra, 8($sp)
sw $t0, 4($sp)
sw $t1, 0($sp)
jal factorial
lw $t1, 0($sp)
lw $t0, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 12
mult $t0, $t1
mflo $v0
addi $sp, $sp, -4
sw $v0, 0($sp)
jr $ra

main:
addi $a0, $0, 5
addi $sp, $sp, -4
sw $a0, 0($sp)
jal factorial
lw $s0, 0($sp)
lw $a0, 4($sp)
addi $sp, $sp, 8
