.data
	list: .byte 12, 3, 4, 3, 5
	msg: .asciiz "\n Deleting element..."
	newLine: .asciiz "\n"
.text

	main:
	
		la $a3, list
		addi $a1, $zero,8 #Size
	
		addi $s0, $zero,0 #Index for while1
		
		addi $s7, $zero, 0 #Size of ListB
		
		jal createListB
	
		while1: bge $s0,$a1, exitWhile1
				
		#Indexing list[s0]
		
			addu $a2,$a3,$s0
			lb $s2,($a2) # s2= list[s0]
		
			move $a2,$s2	
			jal searchInList
		
			bne $v1,$zero,Else
		
			move $a2,$s2
			jal addToList
		
			Else:
		
			addi $s0,$s0,1
	
			j while1
	
	exitWhile1:
		
		move $s5,$v0
		
		sub $s5,$s5,$s7
		
		addi $s5,$s5,4
		li $v0,1
		lb $a0,($s5)
		syscall
	
	
		 li $v0,10
		 syscall
		 
	
	searchInList:
		
		move $t0,$a2
		add $t2,$zero,$s7 
		
		addi $t1,$zero,1 #Index for while
		
		
		While2:
			beq $t2,$zero,ExitWhile2
			
			
			sub $a2,$v0,$t1
			lb $a2,($a2)
			
			beq $a2,$t0,AlreadyContain
			addi $t1,$t1,1
			sub $t2,$t2,1
			j While2		
		
		ExitWhile2:
			addi $v1, $zero, 0
			
			jr $ra
		
		AlreadyContain:
			addi $v1,$zero, 1
			
			jr $ra
	
	addToList:
		move $t0,$a2
		
		
		sb $t0,($v0)
		addu $v0,$v0,1
		
		add $s7, $s7,1
		
		jr $ra
			
	
	createListB:
		li $v0,9
		li $a0,10
		syscall
		
		jr $ra
	
	


		
		
