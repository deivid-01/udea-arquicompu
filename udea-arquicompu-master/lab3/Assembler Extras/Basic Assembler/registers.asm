.data
	newLine: .asciiz "\n"
.text 
	main:
		addi $s0, $zero, 10
		
		jal increaseMyRegister
		
		#Print new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		#Print value
		li $v0, 1
		move $a0, $s0
		syscall
	
	# T registers
	# S registers inside function save the old the value to the stack ( Does not change)
	#This lines is going to signal end of program
	li $v0, 10
	syscall
	
	increaseMyRegister:
		#sp-> stack pointer
		addi $sp, $sp,-4 # -4, allocate four bytes in the stack, and the stack is going down ( negative signal)
		sw $s0, 0($sp) # Save the value S0 to the first location to the stack pointer
		
		addi $s0, $s0, 30
		
		
		#Print new Value in fuction
		li $v0, 1
		move $a0,$s0
		syscall
		
		lw $s0, 0($sp) # Get again s0, the value store at the stack
		addi $sp, $sp, 4 # Restart stack
		
		jr $ra
