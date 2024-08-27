# inicializa o ponteiro
# da stack para um endereço
# conhecido
addi $sp, $0, 0x7FFFEFFC

j main

recursive:
	# carrega o argumento
	# da stack
	lw $t0, 0($sp)
	addi $sp, $sp, 4

	# se o argumento não for zero
	# não retorna, ainda
	bne $t0, $0, else

	# armazena 0 na stack
	addi $sp, $sp, -4
	sw $t0, 0($sp)

	# retorna 0 para o chamador
	jr $ra

	else:
	# decrementa o argumento
	addi $t0, $t0, -1

	# armazena o argumento
	# e o endereço de retorno
	# na stack
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $ra, 4($sp)

	# chama a função recursiva
	jal recursive

	# carrega o argumento
	# e o endereço de retorno
	# da stack
	lw $t0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8

	# incrementa o argumento
	addi $t0, $t0, 1

	# armazena o argumento
	# incrementado na stack
	addi $sp, $sp, -4
	sw $t0, 0($sp)

jr $ra

main:
	# carrega o argumento
	addi $s0, $0, 0xABCD

	# armazena o argumento
	# na stack
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	# chama a função
	jal recursive

	# carrega o resultado
	# da stack
	lw $s1, 0($sp)
	addi $sp, $sp, 4

j exit

exit:
	addi $v0, $0, 10
	syscall
# exit

# analises solicitadas
# nas questões:

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
