.data
	fileName: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/data.txt"
	textFile: .space  1024
	
	messageInit: .asciiz " Enter sentence to search: "
	sentence: .space 20
	sentenceMessage: .asciiz "\nSentence: "
	aparitionsMessage: .asciiz "Number of aparitions: "
.text
		
	main: 
		

		jal printMessageInit 
		
		jal readFile
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
	readFile:
	#Open File	
		li $v0, 13		# System call for open file
		la $a0, fileName	# Input file name
		li $a1, 0		# Open for reading (flag = 0)
		syscall			# Open a file (file descriptor returned in $v0)
		move $s0, $v0		# Copy file descriptor
	
	# Read from file
		li $v0, 14		# System call for reading from file
		move $a0, $s0		# File descriptor
		la $a1, textFile	# Address of input buffer
		li $a2, 20000		# Maximum number of characters to read
		syscall			# Read from file
		move $t9, $v0		# Copy number of characters read
	
	#Close the file
		li $v0, 16
		move $a0,$s0
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
		
		addi $t6,$zero,0 #Counter of ocurrences
		
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
			la $a0,sentenceMessage
			syscall
			
			li $v0,4
			la $a0,sentence
			syscall
			
			li $v0,4
			la $a0,aparitionsMessage
			syscall
			
			li $v0, 1
			move $a0,$t6
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
		
		addi $t6,$t6,1
		
		addi $t0,$t0,1
		addi $t1,$zero,1
		
		
		j while	
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
	
	

		
	
		
		

