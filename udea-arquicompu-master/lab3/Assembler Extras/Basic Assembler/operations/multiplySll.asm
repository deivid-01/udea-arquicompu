.data

.text
	#sll-> shif left logical allows efficient multiplication
	#srl-> shif right  logical allows efficient division
	addi $s0, $zero, 4
	
	sll $t0, $s0,2 # 2 is the exponent like 4 elevadoa  la 2
	
	#Print
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
