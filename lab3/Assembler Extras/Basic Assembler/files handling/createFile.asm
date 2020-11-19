.data

	str_exit: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/result.txt"
	sentence: .asciiz "This is a test!\n"
	input_buffer:	.space 20000
.text
	main:

#Create file
	li $v0, 13
	la $a0, str_exit
	li $a1, 9            
	la $a2, 0           
	syscall
	move $s1,$v0
	
	addi $t9,$zero,16 #Number of character to write
	
# Append a sentence to a file

	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, sentence	# Address of buffer from which to write
	move $a2, $t9		# Number of characters to write
	syscall
	
	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	la $a1, sentence	# Address of buffer from which to write
	move $a2, $t9		# Number of characters to write
	syscall
	
#Close file
	
	li   $v0, 16       # system call for close file
	move $a0, $s1      # file descriptor to close
	syscall            # close file
			
Exit:	li   $v0, 10		# System call for exit
	syscall
