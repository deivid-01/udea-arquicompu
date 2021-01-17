.data

.text
	addi $t0, $zero, 2000
	addi $t1, $zero, 10
	
	mult $t0, $t1 # The result is store in hi and lo registers | # It can be biggers number
	
	mflo $s0 # Get the value from lo who has the result of the previous multiplication
	
	#Display on Screen
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	

