.data
	x : .word 20000 
	y : .word 9000

.text

	lw $a0,x
	lw $a1,y
	
	bgt $a1,10000,NotBelong # y <= 10.000
	
	sub $s0,$a1,$a0
	
	blt $s0,-30000, NotBelong # y - x >= 30,000
	
	add $s0,$a1,$a0
	
	blt $s0,8000, NotBelong # y + x >= 8000
	
	Belong:
	
		addi $v0,$zero,0
		move $a0,$v0
		
		#Print
		li $v0, 1

		syscall
		
		li $v0, 10
		syscall
	NotBelong:
		addi $v0,$zero,-1
		move $a0,$v0
		
		#Print
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
	
	