.data
matrix: .word 1,2,3,4,5,6,7,8,9,10
		.word 11,12,13,14,15,16,17,18,19,20
		.word 21,22,23,24,25,26,27,28,29,30
		.word 31,32,33,34,35,36,37,38,39,40
		.word 41,42,43,44,45,46,47,48,49,50
		.word 51,52,53,54,55,56,57,58,59,60
		.word 61,62,63,64,65,66,67,68,69,70
		.word 71,72,73,74,75,76,77,78,79,80
		.word 8,82,83,84,85,86,87,88,89,90
		.word 91,92,93,94,95,96,97,98,99,100

size: .word 10
data_size: .word 4
.text
	main: 
	
		la $a0, matrix
		lw $a1, size
		
		jal greaterSmallNumber
		
		li $v0, 10
		syscall
	
	greaterSmallNumber
	
	
		