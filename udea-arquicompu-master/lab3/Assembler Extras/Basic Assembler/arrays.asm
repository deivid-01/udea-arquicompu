.data
	myArray: .space 12
.text
	addi $s0, $zero, 5 
	addi $s1, $zero, 10
	addi $s2, $zero, 15
	
	#Index =$t0
	
	# Add values to array
	addi $t0,$zero, 0
	
	sw $s0, myArray($t0)
	addi $t0,$t0,4 # Add 4 to get to the second position
	sw $s1 myArray($t0)
	addi $t0,$t0,4
	sw $s2 myArray($t0)
	########################
	# Get values from array
	addi $t3,$zero,8 # In this case get the last value (15)
	lw $t6, myArray($t3)
	#Print
	li, $v0, 1
	move $a0,$t6
	syscall
