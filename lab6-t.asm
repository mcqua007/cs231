#Program Description:		Lab 05b
#Author:			Sean McQuaid
#Creation Date:                 09/17/2018

	.data
arr:	.word	0,0,0,0,0,0,0,0,0,0
str1:	.asciiz	"Enter number "
colon:	.asciiz	":\t\t"
mstr:	.asciiz	"Enter the number of elements: "
error1:	.asciiz	"Error: Array can't have more than 10 elements.\n"
error2:	.asciiz "Error: Array can't be less than 1 element.\n"
fin:	.asciiz	"The median is: "
skip:	.asciiz	"\n"

	.text

main:	li $v0, 4
	la $a0, mstr	#print string
	syscall

	li $v0, 5		  #read the integer
	syscall

	add $s0, $v0, $0
	li $s7, 10		  # set the MAX
	li $s6, 0	     	# set the counter
	li $s5, 1		    # set for counter for messages
	la $s1, arr		  # set address for array

	bgt $s0, $s7, errHi	#if the int is greater than, jump to error
	ble $s0, $0, errLo	#if the int is less than 1, jump to error
	j mLo


errHi:	li $v0, 4		#print the error
	la $a0, error1
	syscall

	j main

errLo:	li $v0, 4		#print the error
	la $a0, error2
	syscall

	j main

mLo:	beq $s6, $s0, check
	li $v0, 4
	la $a0, str1		#print the first part of the enter string
	syscall

	li $v0, 1		    #print which number it is
	add $a0, $s5, $0
	syscall

	li $v0, 4		    #print the colon with the tabs.
	la $a0, colon
	syscall

	li $v0, 5		     #input the numbers
	syscall

	sw $v0, 0($s1)	 # move the int to the array

	add $s1, $s1, 4  # this is moving the pointer in the array
	add $s6, $s6, 1  # this is the counter of the loop
	add $s5, $s5, 1  # this is the counter for printing messages

	j mLo

# Check to see if if array is odd or even

check:	li $s4, 2
	div $s0, $s4	# divide the max by 2 to find the median array index
	mfhi $t1	    # move the remainder to a temp

	beq $t1, $0, even  #checking if remainder is 0 then jump even
	bne $t1, $0, odd   #checking if remainder is not 0 then jump odd


even:

  la $s1, arr      #load array into regiser $s1

	li $v0, 4
	la $a0, fin	     #"The median number is"
	syscall

  li $t3, 4        #Load $ into register $t3 in order to mult by 4
 	mflo $t2

	mult $t2, $t3	   #Multiply the quotient by 4 find how many bytes we need to move to get correct median

	mflo $t4         # move the product in to register $t4 -
	sub $t4, $t4, 4  #subtract register $t4 by 4 on order to go to the firs tmedian number

	add $s1, $s1, $t4	 #displace the address to point to the first median element
	lw $t5, 0($s1)		 #load the first median element into a temp variable

	add $s1, $s1, 4		#add 4 to find the second median element
	lw $t6, 0($s1)		#load the second median element into a temp variable

	add $t7, $t6, $t5	#add both elements together
	div $t7, $s4	  	#divide by 2
	mflo $t0		      #move the dividend to t0

	li $v0, 1
	add $a0, $t0, $0	#display the median number
	syscall

	j exit

odd:

  la $s1, arr

	li $v0, 4
	la $a0, fin	#"The median number is"
	syscall

	li $t3, 4
	add $s0, $s0, 1	#add 1 to make an even number
	div $s0, $s4	#divide by two to find median address
	mflo $t4	#move dividend to t4
	mult $t4, $t3	#mult the divident by 4
	mflo $t5
	sub $t5, $t5, 4

	add $s1, $s1, $t5	#offset the address

	li $v0, 1
	lw $a0, 0($s1)
	syscall

	j exit

exit:	li $v0, 10
	syscall
