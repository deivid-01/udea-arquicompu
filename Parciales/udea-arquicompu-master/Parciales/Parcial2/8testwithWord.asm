.data
array1: .word   1,,3,4,5,6,7,8,9

.text
main:
        la  $a0,array1
       		add
        addi  $t1,$zero,0

laWhile:
        lw  $t2,($a0)
        beq $t2,$zero,endLaWh
        addi    $t1,$t1,1
        addi    $a0,$a0,4
        j   laWhile

endLaWh:    
        move    $v0,$t1
        