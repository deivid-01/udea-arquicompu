############ README #########
# 1. before run , set route of the corresponding textfile in "filename"
### REGISTERS
# $t8-> contains the lenght of textFile 
# $t9-> contains the lenght of sentence



############################



.data
	#Routes
	inputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/input.txt" # Set global route
	outputFile: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/output.txt"
	
	#Lenghts
	inputFileSize: .space  1024 # Size of textFile
	sentence: .space 20 # Size of sentence
	
	########## MESSAGES ###################################
	
	messageInit: .asciiz " Enter sentence to search: "
	sentenceMessage: .asciiz "\nSentence: "
	aparitionsMessage: .asciiz "Number of aparitions: "
	
.text
		
	main: 
		
		jal loadInputFile

		jal printMessageInit 
	
		jal readSentence	#Read user input
		
		jal getLenghtSentence # $t5=sentence.Lenght
		
	
		
		jal searchSentenceInTextFile
		
		jal setOutputFile
		
	
	
	li $v0, 10
	syscall

##################################### MAIN METHODS

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
		move $t8, $v0		# Copy number of characters read
	
	#Close the file
		li $v0, 16
		move $a0,$t0
		syscall
	
		jr $ra

setOutputFile:
	
	#Create file
		li $v0, 13
		la $a0, outputFile
		li $a1, 9            
		la $a2, 0           
		syscall
		move $s1,$v0
	

	
# Append a sentence to a file

		li $v0, 15		# System call for write to a file
		move $a0, $s1		# Restore file descriptor (open for writing)
		la $a1, sentence	# Address of buffer from which to write
		addi $a2, $t9,1		# Number of characters to write
		syscall
	
	
#Close file
	
		li   $v0, 16       # system call for close file
		move $a0, $s1      # file descriptor to close
		syscall
		
		jr $ra

			
					
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
	searchSentenceInTextFile:
		la $a3,inputFile
		la $a1,sentence
			
		addi $t0,$zero,0 # initial index value for textFile
		addi $t1,$zero,0 # intial index value  for sentence
		
		addi $t6,$zero,0 #Counter of ocurrences
		
		
		sub $t8,$t8,1
		
		while:
					
			bgt $t0,$t8,exit	#if( $to>$t4) | t4 cointains the lenght of textFile
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
			
			jr $ra
			
	
		
		
	getLenghtSentence:
	
		
		la $a1,sentence 
		addi $t9,$zero,0 #t5->Lenght of sentence
		
		whileSentence:
		 
	
			addu $a2,$a1,$t9   
			lbu $a0,($a2)	
		 	
		 	beq $a0,10,exitSentence
			
		 	addi $t9,$t9,1
		 	
		 	j whileSentence
		   
		 exitSentence: 
		 	sub $t9,$t9,1
  			jr $ra	
		
				

######### EXTRA METHODS		

	equalChar:
		beq $t1,$t9,foundSentence	 ###IMPORTANT: Set input sentence lenght here
		bne $t1,$t9,increaseIndexes ###IMPORTANT: Set input sentence lenght here

		
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
	
	

		
	
		
		

