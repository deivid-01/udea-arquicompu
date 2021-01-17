.data
	age: .word 23 # word is four bytes | word or integer
.text
	li $v0, 1 # Prints an integer to the screen with code 1
	lw  $a0, age
	syscall