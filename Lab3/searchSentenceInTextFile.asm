.data
	textFile: .asciiz  "lunabrabola"
	messageInit: .asciiz " Enter sentence to search: "
	sentence: .space 20
	finalMessage: .asciiz "\nThe number of aparitions of  "
	endMessage: .asciiz "\nEnd of the program "
	messageSuccess: .asciiz "Sentence has been found in textFile"
.text
		
	main: 
		
		jal printMessageInit 
		jal readSentence	#Read user input
		jal searchSentence
	
	
	li $v0, 10
	syscall

##################################### MAIN METHODS

#printMessageInit: Print initial message
	printMessageInit: 
		li $v0, 4
		la $a0, messageInit
		syscall
		
		jr $ra
# readSentence: Read input sentence to search	
	readSentence:
		li $v0, 8
		la $a0, sentence
		li, $a1,20
		syscall
				
		jr $ra
		
# searchSentence: Search sentence if textFile
	searchSentence:
		la $a3,textFile
		la $a1,sentence
			
		addi $t0,$zero,0 # initial index value for textFile
		addi $t1,$zero,0 # intial index value  for sentence
		
		while:
					
			bgt $t0,11,exit	#Condition if(t>11)exit
			#Indexing strings############################
			addu $a2,$a3,$t0   
			lbu $a0,($a2)		# a2 = textFile[t0]			
			
			move $t2,$a0		#n-character of textFile
			

			#####################
			addu $a2,$a1,$t1   
			lbu $a0,($a2)		# a0 = sentence[t0]
			
			move $t3,$a0		#n-character of sentence
			
	
			##############################################
			#Compare strings													
			beq $t2,$t3,equalChar
			bne $t2,$t3,equalCharNot
					
		exit:
			li $v0,4
			la $a0,endMessage
			syscall
			
			li $v0, 10
			syscall

######### EXTRA METHODS		

	equalChar:
		beq $t1,3,foundSentence	 ###IMPORTANT: Set input sentence lenght here
		bne $t1,3,increaseIndexes ###IMPORTANT: Set input sentence lenght here

		
	equalCharNot:
		bgt $t1,0, resetIndexSentence
		beqz $t1,increaseIndexTextFile
	
					
	foundSentence:	
		li $v0, 4
		la $a0, messageSuccess
		syscall
		
		li $v0, 10
		syscall		
	increaseIndexes:
		addi $t0,$t0,1 # incremenet t0, t0 is the index
		addi $t1,$t1,1 # incremenet t1, t1 is the index
		
		j while
	resetIndexSentence:
		addi $t1,$zero,0
		j while
		
	increaseIndexTextFile:
		addi $t0,$t0,1
		
		j while # Return to while
	
	

		
	
		
		

