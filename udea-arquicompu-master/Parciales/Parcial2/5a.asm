.data
	list : .byte 6,-2,3,5
.text
	la $s1, list
	addi $s2,$zero, 4 # Size
	addi $t5, $zero, 0 #index
	addi $t0, $zero,0
	While:
		
		bge, $t5, $s2,Exit
		
		addu $a2,$s1,$t5   
		lb $a0,($a2)		# a0 = list[t5]
					
		#abs-> Gets absolute value
		bgt $t5,$zero,Continue
		move $t0,$a0 # Set initial value for t0
		Continue:
		
		bge $a0,$t0,Else
		move $t0,$a0
		Else:		
			
		addi $t5, $t5, 1
			
		j While 	
	
	Exit:
		li $v0,1
		move $a0,$t0
		syscall
	
		li $v0, 10
		syscall
	


