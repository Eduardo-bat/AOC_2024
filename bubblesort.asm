jal main

swap:
addi $sp, $sp, -4
sw $s0, 0($sp)

lw $t0, 0($a0)   #
lw $t1, 0($a1)   #
                 #
add $s0, $t0, $0 # não é necessário fazer a mudança nos registradores
add $t0, $t1, $0 # pode ser otimizado ao, após carregar cada dado,
add $t1, $s0, $0 # os armazenar nos endereços invertidos
                 #
sw $t0, 0($a0)   #
sw $t1, 0($a1)   #

lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra


bubbleSort:
addi $sp, $sp, -16
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $ra, 12($sp)

add $s0, $0, $0

add $s1, $0, $0
addi $t0, $a1, -1
for1: 
bge $s1, $t0, for1_exit
add $s2, $0, $0
sub $t1, $a1, $s1
addi $t1, $t1, -1
for2:
bge $s2, $t1, for2_exit
sll $t6, $s2, 2
add $t2, $a0, $t6
lw $t3, 0($t2)
addi $t4, $t2, 4
lw $t5, 0($t4)
ble $t3, $t5, if_exit
addi $sp, $sp, -16
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $t0, 8($sp)
sw $t1, 12($sp)
add $a0, $t2, $0
add $a1, $t4, $0
jal swap
lw $a0, 0($sp)
lw $a1, 4($sp)
lw $t0, 8($sp)
lw $t1, 12($sp)
addi $sp, $sp, 16
addi $s0, $s0, 1
if_exit:
addi $s2, $s2, 1
j for2
for2_exit:
addi $s1, $s1, 1
j for1
for1_exit:
add $v0, $s0, $0
lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 16
jr $ra

main:

addi $s0, $0, 2
addi $s1, $0, 1
addi $s2, $0, 7
addi $s3, $0, 4
addi $s4, $0, 3
addi $s5, $0, 9
addi $s6, $0, 8
addi $s7, $0, 6

lui $t1, 0x1001
addi $t1, $t1, 0x0020

sw $s0, 0($t1)
sw $s1, 4($t1)
sw $s2, 8($t1)
sw $s3, 12($t1)
sw $s4, 16($t1)
sw $s5, 20($t1)
sw $s6, 24($t1)
sw $s7, 28($t1)

add $a0, $t1, $0
addi $a1, $0, 8

addi $sp, $sp, -4
sw $t1, 0($sp)
jal bubbleSort
lw $t1, 0($sp)
addi $sp, $sp, 4

sw $v0, -4($t1)
