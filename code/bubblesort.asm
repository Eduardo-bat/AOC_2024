j main

swap:
	# salva os registradores
	# que serão usados na função
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	# carrega os valores
	# dos endereços dos elementos
	lw $t0, 0($a0)
	lw $t1, 0($a1)

	# salva os valores
	# nos endereços invertidos
	sw $t1, 0($a0)
	sw $t0, 0($a1)

	# recupera os registradores
	# salvos na stack
	lw $s0, 0($sp)
	addi $sp, $sp, 4
jr $ra

bubbleSort:
	# salva, na stack, os registradores
	# que serão usados na função
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)

	# inicializa o contador de chamadas
	add $s0, $0, $0

	# inicializa o iterador do primeiro loop
	add $s1, $0, $0

	# computa o limite do primeiro loop
	addi $t0, $a1, -1

	# for (s1 = 0; s1 < a1 - 1; s1 ++)
	for1: 
	bge $s1, $t0, for1_exit

	# inicializa o iterador do segundo loop
	add $s2, $0, $0

	# computa o limite do segundo loop
	sub $t1, $a1, $s1
	addi $t1, $t1, -1

	# for (s2 = 0; s2 < a1 - s1 - 1; s2 ++)
	for2:
	bge $s2, $t1, for2_exit

	# computa o endereço do primeiro elemento
	# a ser comparado
	sll $t6, $s2, 2
	add $t2, $a0, $t6

	# carrega o primeiro elemento
	lw $t3, 0($t2)

	# computa o endereço do segundo elemento
	# a ser comparado
	addi $t4, $t2, 4

	# carrega o segundo elemento
	lw $t5, 0($t4)

	# se o primeiro elemento for menor ou igual
	# ao segundo, não chama a função swap
	ble $t3, $t5, if_exit

	# salva os registradores de argumento
	# e auxiliares na stack
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)

	# transfere os endereços dos elementos
	# para os registradores de argumento
	add $a0, $t2, $0
	add $a1, $t4, $0

	# chama a função swap
	jal swap

	# recupera os registradores de argumento
	# e auxiliares da stack
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	addi $sp, $sp, 16

	# incrementa o contador de chamadas
	addi $s0, $s0, 1

	if_exit:
	# incrementa o iterador do segundo loop
	addi $s2, $s2, 1

	# volta para o início do segundo loop
	j for2

	for2_exit:
	# incrementa o iterador do primeiro loop
	addi $s1, $s1, 1

	# volta para o início do primeiro loop
	j for1

	for1_exit:
	# transfere o contador de chamadas
	# para o registrador de retorno
	add $v0, $s0, $0

	# recupera os registradores salvos
	# na stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
jr $ra

main:
	# carrega os valores
	# sobre os quais operar
	addi $s0, $0, 2
	addi $s1, $0, 1
	addi $s2, $0, 7
	addi $s3, $0, 4
	addi $s4, $0, 3
	addi $s5, $0, 9
	addi $s6, $0, 8
	addi $s7, $0, 6

	# prepara o endereço base
	# do vetor a ser ordenado
	lui $t1, 0x1001
	addi $t1, $t1, 0x0020

	# armazena os valores
	# no vetor
	sw $s0, 0($t1)
	sw $s1, 4($t1)
	sw $s2, 8($t1)
	sw $s3, 12($t1)
	sw $s4, 16($t1)
	sw $s5, 20($t1)
	sw $s6, 24($t1)
	sw $s7, 28($t1)

	# transfere o endereço do vetor
	# e seu comprimento
	# para os registradores de argumento
	add $a0, $t1, $0
	addi $a1, $0, 8

	# salva t1 na stack
	addi $sp, $sp, -4
	sw $t1, 0($sp)

	# chama a função bubbleSort
	jal bubbleSort

	# recupera t1 da stack
	lw $t1, 0($sp)
	addi $sp, $sp, 4

	# salva a quantidade de chamadas
	# da função swap em -4(t1)
	sw $v0, -4($t1)

j exit

exit:
	li $v0, 10
	syscall
# exit
