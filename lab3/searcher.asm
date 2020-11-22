############ README #########
# 1. before run , set route of the corresponding textfile in "filename"
### REGISTERS
# $s6-> contains the lenght of textFile 
# $s7-> contains the lenght of sentence
# #s5-> contains number of ocurrencies

# $s4- > address outputfile

############################



.data
	#Routes
	inputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/input.txt" # Set global route
	outputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/output.txt"
	
	#Lenghts
	inputFileSize: .space  1024 # Size of textFile
	sentence: .space 20 # Size of sentence
	answerChar: .space 1
	
	########## MESSAGES ###################################
	
	messageInit: .asciiz "\nEnter sentence to search: "
	sentenceMessage: .asciiz "\nSentence: "
	aparitionsMessage: .asciiz "\nNumber of aparitions: "
	questionInput: .asciiz "\nDo you want search another sentence(Y/N) : "
	successSearch: .asciiz "\n The search was successful"
	successOutput: .asciiz "\nSearch results were added to the output.text file successfully"
	
.text
		
	main: 
		
		jal loadInputFile
		jal createOutputFile
		
		jal readAndSearchSentece
 
		jal closeOutputFile
		
		jal finalMessage
	
	
	li $v0, 10
	syscall



##################################### MAIN METHODS
	finalMessage:
 		li $v0,4
 		la $a0,successOutput
 		syscall
  jr $ra



	createOutputFile:
	#Create file
		li $v0, 13
		la $a0, outputFile
		li $a1, 9            
		la $a2, 0           
		syscall
		move $s4,$v0
		
		jr $ra

closeOutputFile:


		
		li   $v0, 16       # system call for close file
		move $a0, $s4      # file descriptor to close
		syscall
		
		jr $ra
#Load textfile from directory
	loadInputFile:
	#Open File	
		li $v0, 13		# System call for open file
		la $a0, inputFile	# Input file name
		li $a1, 0		# Open for reading (flag = 0)
		syscall			# Open a file (file descriptor returned in $v0)
		move $t0, $v0		# Copy file descriptor
	
	# Read from file
		li $v0, 14		# System call for reading from file
		move $a0, $t0		# File descriptor
		la $a1, inputFileSize	# Address of input buffer
		li $a2, 20000		# Maximum number of characters to read
		syscall			# Read from file
		move $s6, $v0		# Copy number of characters read
		
		sub $s6,$s6,1
	
	#Close the file
		li $v0, 16
		move $a0,$t0
		syscall
	
		jr $ra

	readAndSearchSentece:
		
		addi $sp,$sp,-8
		sw $s0,0($sp)
		sw $ra, 4($sp) #Saving Address of main function
		loopReadAndSearchSentece:	

			jal printMessageInit 
					
			jal readSentence
			
			jal getLenghtSentence 
			
			jal searchSentenceInTextFile
			
			jal setOutputFile
			
			jal checkContinueSearch
	
			beq $t0,78,exitLoopReadAndSearchSentece

			j loopReadAndSearchSentece
		
				
		exitLoopReadAndSearchSentece:
			lw $ra, 4($sp) #Saving Address of main function
			jr $ra

#####################
	printMessageInit: 
		
		li $v0, 4
		la $a0, messageInit
		syscall
		
		jr $ra
				
#######################
# readSentence: Read input sentence to search	
	readSentence:
		li $v0, 8
		la $a0, sentence
		li $a1,20
		syscall

		jr $ra

#########################
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







setOutputFile:
		
# Append a sentence to a file

		li $v0, 15		# System call for write to a file
		move $a0, $s4		# Restore file descriptor (open for writing)
		la $a1, sentenceMessage	# Address of buffer from which to write
		addi $a2, $zero,11		# Number of characters to write
		syscall
		
		li $v0, 15		# System call for write to a file
		move $a0, $s4		# Restore file descriptor (open for writing)
		la $a1, sentence	# Address of buffer from which to write
		addi $a2, $s7,1		# Number of characters to write
		syscall
				
		li $v0, 15		# System call for write to a file
		move $a0, $s4		# Restore file descriptor (open for writing)
		la $a1, aparitionsMessage	# Address of buffer from which to write
		addi $a2, $zero,23		# Number of characters to write
		syscall	

####################SAVING OCURRENCIES IN FILE
		
		li $v0, 9
		li $a0, 10   # allocate 4 bytes for 4 chars
		syscall
		move $s0, $v0


		addi $s0, $s0, 3    # point to the end of the buffer

		
		ble $s5,9,lessThanTen
		
		addi $t8,$zero,10
	
		while2:

		div $s5,$t8
		
		mflo $s3
		move $s5,$s3
	
		mfhi $t4
	
	
		addi $t5, $t4,48      # end line with \n
		sb $t5, 0($s0)
		addi $s0, $s0, -1
	
	
		ble $s5,9,exit2
		j while2
	
		exit2:
		addi $t5, $s3,48      # end line with \n
		sb $t5, 0($s0)
	
		lessThanTen:
		addi $t5, $s5,48      # end line with \n
		sb $t5, 0($s0)

	
		
		li $v0, 15		# System call for write to a file
		move $a0, $s4		# Restore file descriptor (open for writing)
		move $a1, $s0	# Address of buffer from which to write
		addi $a2, $zero,3		# Number of characters to write
		syscall	

		
		
		
		
	
	
#Close file
	


			
					
#printMessageInit: Print initial message

		
# searchSentence: Search sentence if textFile
	searchSentenceInTextFile:
		la $a3,inputFileSize
		la $a1,sentence
			
		addi $t0,$zero,0 # initial index value for textFile
		addi $t1,$zero,0 # intial index value  for sentence
		
		addi $s5,$zero,0 #Counter of ocurrences
		
		
		 #contains the lenght of textFile 
		

		
		
		while:
					
			bgt $t0,$s6,exit	#if( $to>$s6)
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
			la $a0,successSearch
			syscall

			
			jr $ra
			
	
		
		
	getLenghtSentence:
	
		
		la $a1,sentence 
		addi $s7,$zero,0 
		
		whileSentence:
		 
	
			addu $a2,$a1,$s7  
			lbu $a0,($a2)	
		 	
		 	beq $a0,10,exitSentence
			
		 	addi $s7,$s7,1
		 	
		 	j whileSentence
		   
		 exitSentence: 
		 	sub $s7,$s7,1
  			jr $ra	
		
				

######### EXTRA METHODS		

	equalChar:
		beq $t1,$s7,foundSentence	 ###IMPORTANT: Set input sentence lenght here
		bne $t1,$s7,increaseIndexes ###IMPORTANT: Set input sentence lenght here

		
	equalCharNot:
		bgt $t1,0, resetIndexSentence
		beqz $t1,increaseIndexTextFile
	
					
	foundSentence:	
		
		addi $s5,$s5,1
		
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
	
	

		
	
		
		

