.eqv ctrl 0xFFFFF000
.eqv stts 0xFFFFF004
.eqv rslt 0xFFFFF008

.eqv ack	 0
.eqv start 1
.eqv sdone 2
.eqv samps 5

main:
	
	addi $s0, $0, samps
	addi $s1, $0, samps
	addi $s2, $0, sdone
	addi $s3, $0, 0
		
		samples_loop:
			beq $s0, $0, samples_done
			
			addi $t0, $0, start
			sw $t0, ctrl
			
			wait_for_sample:
				lw $t0, stts
				bne $t0, $s2, wait_for_sample
			
			lw  $t0, rslt
			add $s3, $s3, $t0
			
			addi $t0, $0, ack
			sw $t0, ctrl
				
			addi $s0, $s0, -1
			j samples_loop
	
		samples_done:
			div $s3, $s1
		
	addi $v0, $0, 10
	syscall
