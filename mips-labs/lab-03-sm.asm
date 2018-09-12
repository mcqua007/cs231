#Program Description:
#Author:		Sean McQuaid
#Creation Date:                 09/07/2018

.data
str: .asciiz "How many numbers would you like to add ? \n"
str1: .asciiz "Enter a number: "
str2: .asciiz "The sum of even numbers: "

.text

main:

	li $v0, 4	#print the string
	la $a0, str	#Display the question string
	syscall

	li $v0, 5	#begin reading a integers
	syscall

	add $s0, $v0, $0	#move integer from v0 to

	li $s1, 0 #counter - initalize $s1 to 0

	li $s2, 0 #sum - initalize to 0

	li $t1, 2 #is 2 - initalize to 2

	loop1: beq $s1, $s0, exit

	   li $t0, 0 #temporary place holder
	   li $t2, 0 #holds remaidner - needs to be intialized each time through loop

	   li $v0, 4	 #print the string
	   la $a0, str1	 #Display the Enter  string
	   syscall

	   li $v0, 5	#begin reading integers
	   syscall

	   add $t0, $v0, $0  #move into temporary register

	   div $t0, $t1   # devide $t0 by $t1 which is $t0/2

	   mfhi $t2  # move remainder into $t2

	   bne $t2, $0, else1 # if $t2 0

              add $s2, $s2, $t0 # added the sum if its even

	   else1:

	   addi $s1, $s1, 1  # counter adding 1 to each loop through

	   j loop1

	exit:

	   li $v0, 4	#print the string 2
	   la $a0, str2	#Display the sum  string
	   syscall

	   add $a0, $s2, $0
     li $v0, 1
     syscall

           li $v0, 10  # Exit Program
           syscall
