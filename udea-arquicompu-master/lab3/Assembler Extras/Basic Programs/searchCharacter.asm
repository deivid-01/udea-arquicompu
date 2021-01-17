.data
	string: .asciiz  "Hola a todos"
	messageInit: .asciiz " Enter character to search: "
	character: .space 5
	finalMessage: .asciiz "\nThe number of aparitions of  "
.text
		#1. leer los datos de entrada del usuario( Palabra)
	main: 
		
		jal printMessageInit
		jal readCharacter	
		jal searchAndCount
	
	li $v0, 10
	syscall
	
	equal:
		addi $t8,$t8,1 # incremenet t8, t8 is the counter
		ble $t0,12,while # Return to while
	printMessageInit: 
		li $v0, 4
		la $a0, messageInit
		syscall
		
		jr $ra
	readCharacter:
		li $v0, 12
		la $a0, character
		li, $a1,3
		
		syscall
		
		move $s1,$v0 

		jr $ra
	
	searchAndCount:
		la $a1,string
		addi $t0,$zero,0 # initial index value
		addi $t0,$zero,0

		while:
			
			bgt $t0,12,exit 	#and the end of the array exit the program
			
			addu $a2,$a1,$t0   # $a1 = &str[x].  assumes x is in $s0
			lbu $a0,($a2)		# read the character

			
			    			                  	    			                  	
			addi $t0,$t0,1 	# Increment index
			
			#beq $s1,$a0,equal	# Check if the input character is equal to the character of the array
		
			j while
			
		exit:
		
		
			li $v0,4
			la $a0,finalMessage
			syscall
			
			#Show number of aparitions			
			li,$v0,1
			move $a0,$t8
			syscall
		
