.data

.text

	li $v0,9
	li $a0,10
	syscall
	
	addu $a0,$zero,20
	
	addi $t0,$zero,3	
	sb $t0,($v0)
	
	addi $t0,$zero,7
	addu $v0,$v0,1	
	sb $t0,0($v0)
	
	
	addi $v0,$v0,3
	
	lb $a0,0($v0)
	
	li $v0,1
	syscall
	
	
	