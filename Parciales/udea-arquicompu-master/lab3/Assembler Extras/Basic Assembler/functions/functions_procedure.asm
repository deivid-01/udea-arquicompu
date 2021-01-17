#Functions= Procedure (Método)
.data
	message: .asciiz "Hi, everybody.\nMy names is Deivid.\n"
.text
	main: 
		jal displayMessage #Calling method|JAL->Jump and link
	
	#Tell the system the program is done 
	li $v0, 10
	syscall
	
	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		
		jr $ra # Go back to the caller ( In this case goback to main"
			
	
	