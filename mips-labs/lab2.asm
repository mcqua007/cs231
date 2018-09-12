#Program Description:		This is a basic calculator 
#Author:		Sean McQuaid
#Creation Date:                 09/07/2018

	.data

str:	.asciiz "Please enter the two numbers: \n"
sum:	.asciiz "\nSum is\t\t"
diff:	.asciiz "\nDifference is\t"
pro:	.asciiz "\nProduct is\t\t"
quo:	.asciiz "\nQuotient is\t\t"
remstr:	.asciiz "\nRemainder is\t"
	.text

main:
	li $v0, 4	#print the string
	la $a0, str	#Display the question string
	syscall

	li $v0, 5	#begin reading integers
	syscall

	add $s0, $v0, $0	#move integer from v0 to s0
	li $v0, 5	        #read another integer
	syscall

	add $s1, $v0, $0	#move integer from v0 to s1

	li $v0,4	#print the sum string
	la $a0, sum	#load the sum string
	syscall

	li $v0,1	#print the integer
	add $t0, $s0, $s1	#add the integer
	add $a0, $t0, $0	#move the added integer to a0
	syscall

	li $v0, 4	#print the diff string
	la $a0, diff	#load diff string
	syscall

	li $v0,1	#print the integer
	sub $t0, $s0, $s1	#subtract the integer
	add $a0, $t0, $0	#move the subtracted integer to a0
	syscall

	li $v0, 4	#print the pro string
	la $a0, pro	#load pro string
	syscall

	li $v0,1	#print the integer
	mult $s1, $s0	#multiply the integer
	mflo $a0	#move the multiplied integer to a0
	syscall

	li $v0, 4	#print the quo string
	la $a0, quo	#load quo string
	syscall

	li $v0,1	#print the integer
	div $s0, $s1	#divide the integer
	mflo $a0	#move the divided integer to a0
	syscall

	li $v0, 4	#print the rem string
	la $a0, remstr	#load rem string
	syscall

	li $v0,1	#print the integer
	mfhi $a0	#move the divided integer to a0
	syscall

	li $v0, 10
	syscall
