############ README #########
# 1. Before run , set corresponding routes in inputFile and outpuFile
###########################
.data
	#Routes
	inputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/input.txt" # Set global route
	outputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/output.txt"
	
	#Lenghts
	inputFileBuffer: .space  10000 # Size of textFile
	sentence: .space 20 # Size of sentence
	answerChar: .space 1
	
	########## MESSAGES ###################################
	
	messageInit: .asciiz "\nEnter sentence to search: "
	sentenceMessage: .asciiz "\nSentence: "
	aparitionsMessage: .asciiz "\nNumber of aparitions: "
	questionInput: .asciiz "\nDo you want search another sentence(Y/N) : "
	successOutput: .asciiz "\nSearch results were added to the output.text file successfully"
	
.text
		
	main: 
		
		jal loadInputFile
		
		move $s6,$v1 # $v1  returns  the number of characters read from input file
		
		jal createOutputFile
		
		move $s4,$v1 #$v1 Returns the address of outputFile
		
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


####### createOutputFile: Creates the corresponding output file which will save the search results
createOutputFile:
		li $v0, 13
		la $a0, outputFile
		li $a1, 9            
		la $a2, 0           
		syscall
		move $v1,$v0
		
		jr $ra
###### closeOutputFile: Close outputFile from directory
closeOutputFile:		
		li   $v0, 16       # system call for close file
		move $a0, $s4      # file descriptor to close
		syscall
		
		jr $ra
		
###### loadInputFile: Load textfile from directory
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
		la $a1, inputFileBuffer	# Address of input buffer
		li $a2, 20000		# Maximum number of characters to read
		syscall			# Read from file
		
		move $v1, $v0		# Copy number of characters read
		
		sub $v1,$v1,1
	
	#Close the file
		li $v0, 16
		move $a0,$t0
		syscall
	
		jr $ra


### readAndSearchSentece: Reads and search the sentence entered by the user
readAndSearchSentece:
		#Saving Address of main function
		addi $sp,$sp,-8
		sw $s0,0($sp)
		sw $ra, 4($sp) 
		
		loopReadAndSearchSentece:	

			jal printMessageInit 
					
			jal readSentence
			
			jal getLenghtSentence 
			
			move $s7,$v1 # $v1 Retuns the lenght of entered sentence
			
			#Settings arguments for searchSentence		
			move $a2,$s7	
			move $a0,$s6	#Characters lenght of input TextFile
					
			jal searchSentence
			
			move $s5,$v1 #Returns occurrences number of entered sentence
					
			
			#Settings arguments for addResultToOutputFile
			move $a0,$s7	#Characters lenght of entered sentence
			move $a1,$s4	#Address Outputfile
			move $a2,$s5	#Ocurrences sentence
			
			jal addResultToOutputFile		
			
			jal checkContinueSearch
			
			move $t0,$v1 # $v1 Returns the user answer
			
			beq $t0,78,exitLoopReadAndSearchSentece #(if ==78) Exit | 78->N (ASCII)

			j loopReadAndSearchSentece
		
				
		exitLoopReadAndSearchSentece:
			lw $ra, 4($sp) #Getting Address of main function
			jr $ra

### printMessageInit: Prints initial message

printMessageInit: 
		li $v0, 4
		la $a0, messageInit
		syscall
		
		jr $ra			
### readSentence: Read  sentence to search	
readSentence:
		li $v0, 8
		la $a0, sentence
		li $a1,20
		syscall

		jr $ra
### getLenghtSentence: Gets the lenght of entered sentence
getLenghtSentence:
			
		la $a1,sentence 
		addi $t7,$zero,0 
		
		whileSearchSentenceGetLenghtSentence:
		 
	
			addu $a2,$a1,$t7  
			lbu $a0,($a2)	
		 	
		 	beq $a0,10,exitGetLenghtSentence
			
		 	addi $t7,$t7,1
		 	
		 	j whileSearchSentenceGetLenghtSentence
		   
		 exitGetLenghtSentence: 
		 	sub $t7,$t7,1
		 	move $v1,$t7
  			jr $ra	

### checkContinueSearch: Ask the user if they want to enter another sentence
checkContinueSearch:
			li $v0, 4
			la $a0,questionInput
			syscall
		
			li $v0, 12
			la $a0, answerChar
			li $a1,1
			syscall
		
			move $v1,$v0
			
			jr $ra

### addResultToOutputFile: Add serch result to output File
addResultToOutputFile:
		
# Append a sentence to a file
		move $t7,$a0
		move $t4,$a1
		move $t6 ,$a2
		
		li $v0, 15		# System call for write to a file
		move $a0, $t4		# Restore file descriptor (open for writing)
		la $a1, sentenceMessage	# Address of buffer from which to write
		addi $a2, $zero,11		# Number of characters to write
		syscall
		
		li $v0, 15		# System call for write to a file
		move $a0, $t4		# Restore file descriptor (open for writing)
		la $a1, sentence	# Address of buffer from which to write
		addi $a2, $t7,1		# Number of characters to write
		syscall
				
		li $v0, 15		# System call for write to a file
		move $a0, $t4		# Restore file descriptor (open for writing)
		la $a1, aparitionsMessage	# Address of buffer from which to write
		addi $a2, $zero,23		# Number of characters to write
		syscall	

####################SAVING OCURRENCIES IN FILE
		
		li $v0, 9
		li $a0, 10   # allocate 4 bytes for 4 chars
		syscall
		move $s0, $v0


		addi $s0, $s0, 3    # point to the end of the buffer

		
		ble $t6 ,9,lessThanTen
		
		addi $t8,$zero,10
	
		whileSearchSentence2:

		div $t6 ,$t8
		
		mflo $s3
		move $t6 ,$s3
	
		mfhi $t4
	
	
		addi $t5, $t4,48      # end line with \n
		sb $t5, 0($s0)
		addi $s0, $s0, -1
	
	
		ble $t6 ,9,exit2
		j whileSearchSentence2
	
		exit2:
		addi $t5, $s3,48      # end line with \n
		sb $t5, 0($s0)
	
		lessThanTen:
		addi $t5, $t6 ,48      # end line with \n
		sb $t5, 0($s0)

	
		
		li $v0, 15		# System call for write to a file
		move $a0, $s4		# Restore file descriptor (open for writing)
		move $a1, $s0	# Address of buffer from which to write
		addi $a2, $zero,3		# Number of characters to write
		syscall	
	

		
# searchSentence: Search sentence if textFile
searchSentence:
		
		move $t4,$a0	#$t4 Saves the characters lenght of textFile 
		move $t5,$a2 	#$t5 sSaves the chracters lenght of sentence
				
		la $a3,inputFileBuffer
		la $a1,sentence
			
		addi $t0,$zero,0 # initial index value for textFile
		addi $t1,$zero,0 # intial index value  for sentence
		
		addi $t6,$zero,0 #Counter of ocurrences
		
	
		whileSearchSentence:
					
			bgt $t0,$t4,exitSearchSentence	
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
					
		exitSearchSentence:

			
			move $v1,$t6

			
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
		
		
		j whileSearchSentence	
	increaseIndexes:
		addi $t0,$t0,1 # incremenet t0, t0 is the index
		addi $t1,$t1,1 # incremenet t1, t1 is the index
		
		j whileSearchSentence
	resetIndexSentence:
		addi $t1,$zero,0
		j whileSearchSentence
		
	increaseIndexTextFile:
		addi $t0,$t0,1
		
		j whileSearchSentence # Return to whileSearchSentence
	
	

		
	
		
		

