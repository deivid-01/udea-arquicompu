.data

	str_exit: .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/result.txt"
	sentence: .sb "ss"
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
	
	addi $t0,$zero,0
	addi $t9,$zero,16 #Number of character to write
	

# Append a sentence to a file

# reservar memoria para 3 chars + \0
	li $v0, 9
	li $a0, 2
	syscall
	
	move $s0, $v0
	
	sw $t9,0($s0)


	li $v0, 15		# System call for write to a file
	move $a0, $s1		# Restore file descriptor (open for writing)
	move $a1, $s0	# Address of buffer from which to write
	move $a2, $t9		# Number of characters to write
	syscall
	
	

	
#Close file
	
	li   $v0, 16       # system call for close file
	move $a0, $s1      # file descriptor to close
	syscall            # close file
			
Exit:	li   $v0, 10		# System call for exit
	syscall
