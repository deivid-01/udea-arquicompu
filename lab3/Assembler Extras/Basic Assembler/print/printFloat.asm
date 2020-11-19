.data
	PI: .float 3.14
.text
	li   $v0, 2 # Get ready to print float
	lwc1 $f12, PI #load the value pi on f12 |lwc1-> low world call processor1
	syscall