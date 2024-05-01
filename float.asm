j main

fop:
l.s $f0, 0($sp)
l.s $f1, 4($sp)
addi $sp, $sp, 8

mtc1 $0, $f10
cvt.s.w $f11, $f10
c.eq.s $f1, $f11
bc1f continue
lui $t0, 0xFFF0
addi $sp, $sp, -4
sw $t0, 0($sp)
continue:
mul.s $f2, $f0, $f1
div.s $f3, $f0, $f1
add.s $f4, $f3, $f2
addi $sp, $sp, -4
s.s $f4, 0($sp)
jr $ra

main:
addi $t0, $0, 0x42206666
addi $t1, $0, 0x3ecccccd
addi $sp, $sp, -8
sw $t0, 0($sp)
sw $t1, 4($sp)
jal fop
l.s $f5, 0($sp)