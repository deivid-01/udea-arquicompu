.data
 	x: .byte 5
 	y: .byte 0
 	message: .asciiz "\nDivision by zero not allowed"
.text
	#Loading bytes
	lb $a0,x
	lb $a1,y
	
	addi $v0,$zero,0 #Quotient
	
	beq $a1,$zero,errDivision
	
	while:
		
		sub $a0,$a0,$a1	#Successive substraction
		
		blt $a0,$zero, exit	#Exit when dividend is less to zero
		
		addi $v0,$v0,1	#increment quotient
		
		j while
		
		
	
	exit:
		abs $v1,$a0 #Getting remainder
	
	#Printing division result
		move $a0,$v0
		li $v0, 1	
		syscall
		

		li $v0, 10
		syscall
	
	errDivision:
		li $v0,4
		la $a0,message
		syscall
		
		li $v0, 10
		syscall
	
	