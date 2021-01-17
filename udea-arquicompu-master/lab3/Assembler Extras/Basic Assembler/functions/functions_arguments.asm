#Functions= Procedure (Método)
.data
.text
	main: 
		#For functions arguments allways use 'a' registers
		addi $a1, $zero,50
		addi $a2, $zero,100
		 
		jal addNumbers 
		
		jal print
		

  
	li $v0, 10
	syscall
	
	addNumbers:
		add $v1, $a1, $a2 # By convention v1 store result of  add, because is use for return values

		jr $ra # Go back to the caller ( In this case goback to main)"
	print:
		li $v0, 1 
		addi $a0, $v1, 0
		syscall
		
		jr $ra		
	
	