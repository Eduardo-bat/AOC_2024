.eqv ctrl_high 0xFFFF
.eqv ctrl_low  0xF000
.eqv stts_high 0xFFFF
.eqv stts_low  0xF004
.eqv rslt_high 0xFFFF
.eqv rslt_low  0xF008

.eqv ack	 0
.eqv start 1
.eqv sdone 2
.eqv samps 5

j main

# v0 <= mem[stts_high|stts_low]
read_stts:
	lui $t0, stts_high
	lw $v0, stts_low($t0)
jr $ra

# v0 <= mem[rslt_high|rslt_low]
read_rslt:
	lui $t0, rslt_high
	lw $v0, rslt_low($t0)
jr $ra

# mem[ctrl_high|ctrl_low] <= a0
write_ctrl:
	lui $t0, ctrl_high
	sw $a0, ctrl_low($t0)
jr $ra

main:
	# inicializa a quantidade de amostras
	# o sinal de leitura concluída
	# e o acumulador de amostras
	addi $s0, $0, samps
	addi $s1, $0, sdone
	addi $s2, $0, 0

	# while (s3 != s0)
	samples_loop:
		beq $s3, $s0, samples_done

		# inicia a leitura de uma amostra
		addi $a0, $0, start
		jal write_ctrl

		# espera a leitura ser concluída
		# while (mem[stts_high|stts_low] != sdone)
		wait_for_sample:
			jal read_stts
			bne $v0, $s1, wait_for_sample

		# carrega a amostra lida
		jal read_rslt

		# acumula a amostra
		add $s2, $s2, $v0

		# incrementa o contador de amostras lidas
		addi $s3, $s3, 1

		# faz a próxima leitura
		j samples_loop

	samples_done:
		# divide o acumulador pelo número de amostras
		div $s2, $s0

j exit

exit:
	addi $v0, $0, 10
	syscall
# exit