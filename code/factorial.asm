j main

factorial:
	# carrega o argumento
	# desta chamada
	lw $t0, 0($sp)
	addi $sp, $sp, 4

	# verifica se o argumento
	# é maior que 0
	bne $t0, $0, greater_than_zero

	# se não for, retorna 1
	addi $t1, $0, 1
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	jr $ra

	greater_than_zero:
	# decrementa o argumento
	addi $t1, $t0, -1

	# salva os registradores
	# que armazenam o estado
	# desta chamada
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	# chama a função factorial
	jal factorial

	# recupera os registradores
	# que armazenam o estado
	# desta chamada
	# e o retorno
	# da chamada recursiva
	lw $t1, 0($sp)
	lw $t0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12

	# calcula k * (k - 1)
	mult $t0, $t1

	# transfere o resultado
	# para o registrador de retorno
	mflo $v0

	# salva o resultado
	# na stack
	addi $sp, $sp, -4
	sw $v0, 0($sp)
jr $ra

main:
	# carrega argumento
	# no registrador $a0
	addi $a0, $0, 7

	# salva o registrador
	# de argumento na stack
	addi $sp, $sp, -4
	sw $a0, 0($sp)

	# chama a função factorial
	jal factorial

	# recupera o valor de retorno
	# e o argumento da stack
	lw $s0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8

j exit

exit:
	li $v0, 10
	syscall
# exit
