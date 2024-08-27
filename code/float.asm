.eqv fourty_dot_one 0x42206666
.eqv zero_dot_four	0x3ecccccd
.eqv nan_upper			0xfff0

j main

fop:
	# carrega os valores da pilha
	# em registradores próprios para floats
	l.s $f0, 0($sp)
	l.s $f1, 4($sp)
	addi $sp, $sp, 8

	# carrega o valor 0
	# em um registrador próprio para floats
	mtc1 $0, $f10

	# converte o valor 0 para float
	cvt.s.w $f11, $f10
	
	# verifica se o valor de f1 é 0
	c.eq.s $f1, $f11

	# se for 0, pula para a label continue
	bc1f continue

	# armazena o valor de nan na pilha
	lui $t0, nan_upper
	addi $sp, $sp, -4
	sw $t0, 0($sp)

	continue:
	# executa as operações
	# nos valores float
	mul.s $f2, $f0, $f1
	div.s $f3, $f0, $f1
	add.s $f4, $f3, $f2

	# armazena os valores na pilha
	addi $sp, $sp, -4
	s.s $f4, 0($sp)
jr $ra

main:
	# carrega os hexadecimais
	# correspondentes aos floats
	addi $t0, $0, fourty_dot_one
	addi $t1, $0, zero_dot_four

	# armazena os valores na pilha
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $t1, 4($sp)

	# chama a função fop
	jal fop

	# carrega o resultado da função
	# em um registrador próprio
	# para floats
	l.s $f5, 0($sp)

j exit

exit:
	addi $v0, $0, 10
	syscall
# exit