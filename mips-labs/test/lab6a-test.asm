#Program Description:		Lab 06a
#Author:			Sean McQuaid
#Creation Date:                 9/26/18

	.data
enter:	.asciiz	"Input a number in decimal form:\t"
output:	.asciiz	" The number binary is: \t"
error:	.asciiz	"The number cannot be less than 0.\n"
	.text

main:	li $v0, 4
	la $a0, enter	#Enter string
	syscall

	li $v0, 5	#read integer
	syscall

	add $a0, $v0, $0	#store the number

	blt $a0, $0, err	#error if less than 0

	jal baseChange

	li $v0, 10
	syscall

baseChange:
	li $s1, 32		#32 max
	li $s2, 0		#counter
	li $s3, 2		#dividend
	add $t1, $a0, $0

loop:	beq $t1, $0, make32		#When t1 = 0, top the loop

	div $t1, $s3
	mfhi $t0		#remainder
	mflo $t1		#quotient

	sub $sp, $sp, 4
	sw $t0, 0($sp)		#push

	addi $s2, $s2, 1

	li $v0, 1
	add $a0, $t1, $0
	syscall

	j loop

make32:	sub $t2, $s1, $s2	#amount of 0's
	li $s4, 0

	li $v0, 4
	la $a0, output		#print output string
	syscall

zloop:	beq $s4, $t2, fin

	li $v0, 1
	li $a0, 0	#print zeros
	syscall

	addi $s4, $s4, 1

	j zloop

fin:	li $s4, 0

oloop:	beq $s4, $s2, exit

	li $v0, 1
	lw $a0, 0($sp)
	syscall

	addi $sp, $sp, 4

	addi $s4, $s4, 1

	j oloop

exit:	jr $ra

err:	li $v0, 4
	la $a0, error
	syscall

	j main
