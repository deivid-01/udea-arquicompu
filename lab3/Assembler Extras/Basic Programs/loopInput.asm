.data
	answerChar: .space 1
	sentence: .space 20 # Size of sentence
	messageInit: .asciiz "\nEnter sentence to search: "
	questionInput: .asciiz "\nDo you want search another sentence(Y/N) : "
.text

	main: 
	 
	 jal readAndSearchSentece
	 
	
	li $v0, 10
	syscall
		
	readAndSearchSentece:
		
		addi $sp,$sp,-8
		sw $s0,0($sp)
		sw $ra, 4($sp) #Saving Address of main function
		loopReadAndSearchSentece:	

			jal printMessageInit 
					
			jal readSentence
		
			jal checkContinueSearch
	
			beq $t0,78,exitLoopReadAndSearchSentece

			j loopReadAndSearchSentece
		
				
		exitLoopReadAndSearchSentece:
			lw $ra, 4($sp) #Saving Address of main function
			jr $ra
		
	
	printMessageInit: 
		li $v0, 4
		la $a0,messageInit
		syscall
		
		jr $ra

	readSentence:
		li $v0, 8
		la $a0, sentence
		li $a1,20
		syscall

		jr $ra
		
	checkContinueSearch:
			li $v0, 4
			la $a0,questionInput
			syscall
		
			li $v0, 12
			la $a0, answerChar
			li $a1,1
			syscall
		
			move $t0,$v0
			
			jr $ra

		
		
		
		