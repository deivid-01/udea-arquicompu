.data
	list: .word 1,9,7,2,8,3,6,10,5,4

.text
	main:
		
		la $s0,list	
		add $t0,$s0,0
		lw $t0,($t0)
		add $t1,$t1,$t0 #gN
		add $t2, $t2,$t0 #sN
		
		add $t3,$t3,0
		Loop:
		beq $t3,40,ExitLoop
		
		add $a0,$s0,$t3
		lw $a0,($a0)
		
		slt $s7,$t1,$a0 #Comparing if(item>gN)
		slt $s6,$a0,$t2 #Comparing if (sn>Item)
		
		beq $s7,$zero,Elif
		addi $t1,$a0,0
		Elif:
		beq $s6,$zero,Else
		add $t2,$a0,0
		Else:
		add $t3,$t3,4
		
		
		j Loop
		ExitLoop:
		
	


