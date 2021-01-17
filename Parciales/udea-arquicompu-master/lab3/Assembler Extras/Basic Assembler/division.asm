.data
fout:   .asciiz "E:/udea/arqui-compu/udea-arquicompu/lab3/result.txt" 
.text


li $v0, 9
li $a0, 10   # allocate 4 bytes for 4 chars
syscall
move $s0, $v0


addi $s0, $s0, 3    # point to the end of the buffer



	addi $t8,$zero,10
	
	ble $t6,9,lessThanTen
	
	while:
	
	
	
	div $t6,$t8
	
	
	mflo $s3
	
	move $t6,$s3
	
	mfhi $s4
	
	
	
	addi $s5, $s4,48      # end line with \n
	sb $s5, 0($s0)
	addi $s0, $s0, -1
	
	
	
	
	ble $t6,9,exit

	
	j while
	
	exit:
	addi $s5, $s3,48      # end line with \n
	sb $s5, 0($s0)
	
	lessThanTen:
	addi $s5, $t6,48      # end line with \n
	sb $s5, 0($s0)

	

	
	
# Open (for writing) a file that does not exist
li   $v0, 13       # system call for open file
la   $a0, fout     # output file name
li   $a1, 1       # Open for writing (flags are 0: read, 1: write)
li   $a2, 0        # mode is ignored
syscall            # open a file (file descriptor returned in $v0)
move $s6, $v0      # save the file descriptor 

# Write to file just opened
li   $v0, 15       # system call for write to file
move $a0, $s6      # file descriptor 
move $a1, $s0      # address of buffer from which to write
li   $a2, 4        # hardcoded buffer length
syscall            # write to file

# Close the file 
li   $v0, 16       # system call for close file
move $a0, $s6      # file descriptor to close
syscall            # close file
	
	
	
li $v0,10
syscall	
