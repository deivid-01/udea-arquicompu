.data
	prompt: .asciiz "Enter your age: "
	message: .asciiz "\nYour age  is "
.text
	#Promp the user to enter age
	li $v0, 4 
	la $a0, prompt
	syscall

	#Get the user's age
	
	li $v0, 5 # Get an integer from the user | Number is gonna be store in V0 
	syscall
	
	#Store the result in t0
	move $t0, $v0, # Send  value of v0 to t0
	
	#Display message
	li $v0, 4
	la $a0, message
	syscall
	
	#Show the age
	
	li $v0, 1
	move $a0, $t0
	syscall