.data
	A : .byte 4,7,10,12
	B : .byte 0,2
.text
	
main:

		addi $s0,$zero,0 #f
	addi $s1, $zero,0  #g
	
	la $s6,A
	la $s7,B
	
	#Setting arugments
	move $a0,$s1 #g
	move $a1,$s6 #A
	move $a2,$s7 #B
	#Calling procedure
	jal getF
	#Returning values
	move $s0,$v1
		
	li $v0, 10
	syscall
	

getF:
	
	move $s1,$a0 #	g
	move $s2,$a1 #	A
	move $s3,$a2 #B

	
	addu $a0,$s3,$s1
	lb  $a0, ($a0)

	addi $a0,$a0,1
	
	addu $a0,$s2,$a0
	lb $v1,($a0)
	
	jr $ra
	
#F


