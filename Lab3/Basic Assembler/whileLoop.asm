.data

.text
	main:
		# i = 0
		addi $t0, $zero,0
		
		while:
			bgt $t0,9,exit # if( i<10)
			
			addi, $t0, $t0,1 # i++
			
			
			
			j while # Go back to while
		
		exit:		
		
	
	
	li, $v0, 10
	syscall
