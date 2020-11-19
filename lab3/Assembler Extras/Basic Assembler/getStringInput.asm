.data
	initmessage: .asciiz "Enter your name: "
	message: .asciiz "Hello,  "
	userInput: .space 20  # The user is gonna insert 20 characteres
.text
	main:
		#Show initmessage
		li $v0, 4
		la $a0, initmessage
		syscall
		
		
		#Get user's name input
		li $v0, 8 # 8-> Read text
		la $a0, userInput
		li $a1, 20  # Maxium size allowed
		syscall
		
	 #Display message
	 
	 	li $v0, 4
	 	la $a0, message
	 	syscall
	 	
	 # Display name
	 	li $v0, 4
	 	la $a0, userInput
	 	syscall
		
	
	#The end of the main
	li $v0, 10
	syscall