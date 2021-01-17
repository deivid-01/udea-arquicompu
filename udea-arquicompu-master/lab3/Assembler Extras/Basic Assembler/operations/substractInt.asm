.data
	number1: .word 20
	number2: .word 8
.text
	lw $s0, number1	#so = 20
	lw $s1, number2	#s1 = 5
	
	sub $t0, $s0, $s1 #=t0=s0-s1
	
	#Print
	li $v0 1
	move $a0, $t0 # Moving the value of t0 to a0
	syscall