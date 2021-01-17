.data
	fileName: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/data.txt"
	textFile: .space 1024
.text
	
	li $v0, 13		# System call for open file
	la $a0, fileName	# Input file name
	li $a1, 0		# Open for reading (flag = 0)
	syscall			# Open a file (file descriptor returned in $v0)
	move $s0, $v0		# Copy file descriptor
	
	# Read from previously opened file
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
	
	#Prints
	li $v0, 4
	la $a0, textFile
	syscall