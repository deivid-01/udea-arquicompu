.data
	message: .asciiz "The number are equal"
	message2: .asciiz "Nothing happend"
.text
	main:
	
	addi $t0, $zero,5
	addi $t1 , $zero,20
	
	beq $t0, $t1,numbersEqual     #branch if equal |Goes to numberEqual if they are really equal
	
	bne $t0, $t1,numbersDifferent # Branch not equal
	
	li $v0, 10
	syscall
	
	
	numbersEqual:
		li, $v0, 4
		la, $a0, message
		syscall

	numbersDifferent:
		li, $v0, 4
		la, $a0, message2
		syscall
									