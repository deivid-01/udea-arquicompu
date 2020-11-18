.data
	textFile: .asciiz  "Kate Winslet guarda su Oscar en el cuarto de baño para que sus invitados puedan sostenerlo e improvisar sus propios discursos de agradecimiento sin sentirse observados."
	messageInit: .asciiz " Enter sentence to search: "
	sentence: .space 20
	finalMessage: .asciiz "\nThe number of aparitions of  "
	endMessage: .asciiz "\nEnd of the program "
	messageSuccess: .asciiz "Sentence has been found in textFile"
	newLine: .asciiz "\n"
.text
		
	main: 
		
		jal printMessageInit 
		jal readSentence	#Read user input
		
		jal getLenghtTextFile # $t4=textFile.Lenght
		jal getLenghtSentence # $t5=sentence.Lenght
		
		
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
					
			bgt $t0,$t4,exit	#if( $to>$t4) | t4 cointains the lenght of textFile
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
			
			
	getLenghtTextFile:
	
		
		la $a1,textFile 
		addi $t4,$zero,0 #t4->Lenght of textFile
		
		whileText:
		 
	
			addu $a2,$a1,$t4   
			lbu $a0,($a2)	
		 	
		 	beq $a0,$zero,exitText
		 			 	
		 	addi $t4,$t4,1
		 	
		 	j whileText
		   
		 exitText: 
		 	sub $t4,$t4,1
  			jr $ra	
		
		
	getLenghtSentence:
	
		
		la $a1,sentence 
		addi $t5,$zero,0 #t4->Lenght of textFile
		
		whileSentence:
		 
	
			addu $a2,$a1,$t5   
			lbu $a0,($a2)	
		 	
		 	beq $a0,10,exitSentence
			
		 	addi $t5,$t5,1
		 	
		 	j whileSentence
		   
		 exitSentence: 
		 	sub $t5,$t5,1
  			jr $ra	
		
				

######### EXTRA METHODS		

	equalChar:
		beq $t1,$t5,foundSentence	 ###IMPORTANT: Set input sentence lenght here
		bne $t1,$t5,increaseIndexes ###IMPORTANT: Set input sentence lenght here

		
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
	
	

		
	
		
		

