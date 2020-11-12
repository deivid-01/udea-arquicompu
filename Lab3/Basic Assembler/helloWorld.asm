# Every MIPS program have two sections: data section and text section
.data # Data has all the data of our program | It would be like variables
	myMessage: .asciiz "Hello world\n"

.text # All the instructions
	li $v0, 4 # Get ready to print something (?) | #v0-> Print value on screen
	la $a0, myMessage # Load message to register | What value?
	syscall # Do it right now!