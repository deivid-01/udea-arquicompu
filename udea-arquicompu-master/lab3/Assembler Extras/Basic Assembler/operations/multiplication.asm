.data

	
	
.text
	addi $s0, $zero, 10  # it just a constant or a number
	addi $s1, $zero, 4 
	
	mul $t0, $s0, $s1 # works with small numbers
	
	#Print
	li $v0, 1
	add $a0, $zero, $t0 # or move $a0, $t0 
	syscall
	  
	
	
	#mul	 # take three registers
	#mult	 #take two registers
	#sll 	#very efficient doest not much flexibility