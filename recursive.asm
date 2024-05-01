addi $sp, $0, 0x7FFFEFFC
j main

recursive:
lw $t0, 0($sp)
addi $sp, $sp, 4

bne $t0, $0, else
addi $sp, $sp, -4
sw $t0, 0($sp)
jr $ra

else:
addi $t0, $t0, -1
addi $sp, $sp, -8
sw $t0, 0($sp)
sw $ra, 4($sp)
jal recursive
lw $t0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8
addi $t0, $t0, 1
addi $sp, $sp, -4
sw $t0, 0($sp)
jr $ra

main:
addi $s0, $0, 0xABCD
addi $sp, $sp, -4
sw $s0, 0($sp)
jal recursive
lw $s1, 0($sp)
addi $sp, $sp, 4

# store s0 -> -4
## sp = sp_0 - 4
# chama rec n
# load inicial de rec -> +4
# não é zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 8
# chama rec n-1
# load inicial de rec -> +4
# não é zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 12
# chama rec n-2
# load inicial de rec -> +4
# não é zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 16
## ...
# chama rec n-k
# load inicial de rec -> +4
# não é zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 8 - 4 * k
## ...
## sp = sp_0 - 8 - 4 * (n-1) = sp_0 - 4 - 4n
# chama rec 0
## no total, são feitas n + 1 chamadas
# load inicial de rec -> +4
# é zero, segue
# store t0 -> -4
## sp = sp_0 - 4 - 4n
# retorno de  0
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4 - 4n + 4 = sp_0 - 4n
# retorno de 1
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4
# retorno de 2
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 8
# retorno de 3
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 12
## ...
# retorno de k
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4k
## ...
## para o programa seguir a partir
## da primeira chamada de função,
## deve retornar todas, até n
# retorno de n - 1
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4(n-1) = sp_0 - 4
# retorno de n
## após retornar da chamada de rec(n),
## já está na main
# load s1 -> 4
## sp = sp_0 - 4 + 4 = sp_0

# chama rec n
# n não é zero, else
# chama rec n - 1
# n não é zero, else
# chama rec n - 2
## ...
# chama rec 0
## no total, n + 1 chamadas
# é zero, segue
# retorna 0
# soma 1
# retorna 1
# soma 1
# retorna 2
## ...
# soma 1
# retorna n
